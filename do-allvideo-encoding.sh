IFS=$'\n'

_TARGET_DIR=/var/www/html/epgrec/video/complete
_DEST_DIR=/mnt/ShareDisk/dlna/Movie/unclassified
_LOGFILE=/var/www/html/epgrec/log/`date +%Y%m%d`_allvideoencoding.log
_EXE_FFMPEG=/var/www/html/epgrec/do-ffmpeg.sh
_CHAPTER_FILE_SRC=/var/www/html/epgrec/chapter_nero.txt
_CHAPTER_FILE_DIR=/var/www/html/epgrec

while [ true ];
do
  #_NUM=`find ${_TARGET_DIR} -maxdepth 1 -type f -name "*.ts" | wc -l`
  #if [ ${_NUM} -eq 0 ]; then
  #  echo break1
  #  break
  #fi
  ls -l ${_TARGET_DIR}/
  ls ${_TARGET_DIR}/*.ts | wc -l
  if [ `ls ${_TARGET_DIR}/*.ts | wc -l` -eq 0 ]; then
    echo break2
    break
  fi
  for _v in ${_TARGET_DIR}/*.ts
  do 
    echo ---------------------------------------
    echo ${_v}
    echo ---------------------------------------
    #echo ${_v} | sed 's/\.tmp\.ts//'
    _mp4_name=`echo ${_v} | sed 's/\.tmp\.ts//'`
    echo `date +'%Y/%m/%d %H:%M:%S'` "[I] EXEC [ ${_EXE_FFMPEG} ${_v} ]" >> ${_LOGFILE}
    echo `date +'%Y/%m/%d %H:%M:%S'` "[I] EXEC [ ${_EXE_FFMPEG} ${_v} ]" 
    #${_EXE_FFMPEG} ${_mp4_name}
    echo ${_EXE_FFMPEG} "${_v}"
    ${_EXE_FFMPEG} "${_v}"
    if [ $? -gt 0 ]; then
      echo "`date +'%Y/%m/%d %H:%M:%S'`" $$ "[E]" "FFMPEG ERROR" >> ${LOGFILE}
      echo "`date +'%Y/%m/%d %H:%M:%S'`" "[I] EXEC [ mv ${_v} ${_TARGET_DIR}/encode_error ] " >> ${_LOGFILE}
      mv ${_v} ${_TARGET_DIR}/encode_error >> ${_LOGFILE}
    else 

      #mv ${_v} ${_TARGET_DIR}/tmp/ >> ${_LOGFILE}
      rm ${_v} >> ${_LOGFILE}

      # 2015/03/13
      cp ${_CHAPTER_FILE_SRC} ${_TARGET_DIR}/${_mp4_name}.chapters.txt
      mp4chaps -i ${_mp4_name}
      rm ${_TARGET_DIR}/${_mp4_name}.chapters.txt

      echo "`date +'%Y/%m/%d %H:%M:%S'`" "[I] EXEC [ mv ${_mp4_name} ${_DEST_DIR} ] " >> ${_LOGFILE}
      mv ${_mp4_name} ${_DEST_DIR} >> ${_LOGFILE}
      echo "`date +'%Y/%m/%d %H:%M:%S'`" "[I] EXEC [ mv ${_v} ${_TARGET_DIR}/tmp ] " >> ${_LOGFILE}
    fi    
  done
done
