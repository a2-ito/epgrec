#!/bin/bash
#echo "CHANNEL : $CHANNEL"
#echo "DURATION: $DURATION"
#echo "OUTPUT  : $OUTPUT"
#echo "TUNER : $TUNER"
#echo "TYPE : $TYPE"
#echo "MODE : $MODE"
#echo "SID  : $SID"

RECORDER=/usr/local/bin/recpt1
FFMPEG="/var/www/html/epgrec/do-allvideo-encoding.sh"
LOGDATETIME=`date +%Y%m%d`
MP4_DESTPATH=/mnt/ShareDisk/dlna/Movie/unclassified/
TS_COMPPATH=/var/www/html/epgrec/video/complete/

# ログ出力
TMPNAME=/var/www/html/epgrec/log/do-record.sh.$$
LOGNAME=/var/www/html/epgrec/log/${LOGDATETIME}_do-record.log
PSNUM=`echo $$ | awk '{printf "%05d\n",$1}'`

# fail safe
case $CHANNEL in
    101|102|191|192|193)
	if [ $SID = 'hd' ]; then
	    SID=$CHANNEL
	fi ;;
esac
if [ -z $SID ]; then
    SID='hd'
fi

STARTTIME="`date +'%Y/%m/%d %H:%M:%S'`"

if [ ${MODE} = 0 ]; then
   #echo ${STARTTIME} "EXEC [ RECORDER --b25 --strip $CHANNEL $DURATION ${OUTPUT} >/dev/null ] " >> ${LOGNAME}
   echo ${STARTTIME} "EXEC [ RECORDER --b25 --strip $CHANNEL $DURATION ${OUTPUT} ] "
   # MODE=0では必ず無加工のTSを吐き出すこと
   $RECORDER --b25 --strip $CHANNEL $DURATION ${OUTPUT} >/dev/null
elif [ ${MODE} = 1 ]; then
   echo ${STARTTIME} ${PSNUM} "[I] EXEC [ $RECORDER --b25 --strip --sid $SID $CHANNEL $DURATION ${OUTPUT} >/dev/null ] " >> ${LOGNAME}
   # 目的のSIDのみ残す
   $RECORDER --b25 --strip --sid $SID $CHANNEL $DURATION ${OUTPUT} >/dev/null
# mode 2 example is as follows
elif [ ${MODE} = 2 -o ${MODE} = 3 ]; then
   echo ${STARTTIME} ${PSNUM} "[I] REC START" >> ${LOGNAME}
   echo ${STARTTIME} ${PSNUM} "[I] PARAM [ CHANNEL : $CHANNEL, DURATION: $DURATION, OUTPUT  : $OUTPUT, TUNER : $TUNER, TYPE : $TYPE, MODE : $MODE, SID : ${SID} ]" >> ${LOGNAME}

   # 2015/02/27
   # $RECORDER $CHANNEL $DURATION ${OUTPUT}.tmp.ts --b25 --strip >> ${LOGNAME}
   if [ ${MODE} = 2 ]; then
     echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] EXEC [ $RECORDER --b25 --strip --sid $SID $CHANNEL $DURATION ${OUTPUT}.tmp.ts ]" >> ${LOGNAME}
     $RECORDER --b25 --strip --sid $SID $CHANNEL $DURATION "${OUTPUT}.tmp.ts" >> ${LOGNAME}
   elif [ ${MODE} = 3 ]; then
     echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] EXEC [ $RECORDER --b25 --strip $CHANNEL $DURATION ${OUTPUT}.tmp.ts ]" >> ${LOGNAME}
     $RECORDER --b25 --strip $CHANNEL $DURATION "${OUTPUT}.tmp.ts" >> ${LOGNAME}
   fi

   echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] EXEC [ $FFMPEG ${OUTPUT} ] " >> ${LOGNAME}
   filename=`basename ${OUTPUT}`

   # 2015/12/30
   if [ ${MODE} = 3 ]; then
     echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] EXEC [assdumper \"${OUTPUT}.tmp.ts\" \> \"${OUTPUT}.assdump\" ] " >> ${LOGNAME}
     assdumper "${OUTPUT}.tmp.ts" > "${OUTPUT}.assdump"
     echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] EXEC [assconv.pl -i \"${OUTPUT}.tmp.ts\" -o \"${OUTPUT}.ass\" ] " >> ${LOGNAME}
     assconv.pl -i "${OUTPUT}.tmp.ts" -o "${OUTPUT}.ass"

     echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] EXEC [ mv ${OUTPUT}.ass ${TS_COMPPATH} ] " >> ${LOGNAME}
     mv "${OUTPUT}.ass" ${TS_COMPPATH} >> ${LOGNAME}
   fi

   echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] EXEC [ mv ${OUTPUT}.tmp.ts ${TS_COMPPATH} ] " >> ${LOGNAME}
   mv "${OUTPUT}.tmp.ts" ${TS_COMPPATH} >> ${LOGNAME}
   #cp -p "${OUTPUT}.tmp.ts" ${TS_COMPPATH} >> ${LOGNAME}

   echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] EXEC [ $FFMPEG ${TS_COMPPATH}/${filename} ]" >> ${LOGNAME}
   _FFMPEG_PSNUM=`ps -ef | grep ffmpeg | grep -v grep | wc -l`
   if [ ${_FFMPEG_PSNUM} -eq 0 ]; then
     # echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] EXEC [ ${FFMPEG} ]" >> ${LOGNAME}
     ls -la /var/www/html/epgrec/video/complete/ >> ${LOGNAME}
     ${FFMPEG} >> ${LOGNAME} 2>&1
     if [ $? -gt 0 ]; then
       echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] ENCODE ERROR " >> ${LOGNAME}
     fi
     echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] REC END" >> ${LOGNAME}
   else
     echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] SKIP ENCODE" >> ${LOGNAME}
   fi
   #echo `date +'%Y/%m/%d %H:%M:%S'` "EXEC [ mv ${OUTPUT} ${MP4_DESTPATH} ] " >> ${LOGNAME}
   #echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] EXEC [ mv ${TS_COMPPATH}/${filename} ${MP4_DESTPATH} ] " >> ${LOGNAME}
   #mv ${TS_COMPPATH}/${filename} ${MP4_DESTPATH}
   #rm -f ${OUTPUT}.tmp.ts
   echo `date +'%Y/%m/%d %H:%M:%S'` ${PSNUM} "[I] REC END" >> ${LOGNAME}
fi

