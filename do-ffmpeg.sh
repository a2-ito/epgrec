

_EXE_FFMPEG=ffmpeg
_EXE_FFMPEG=/home/apache/ffmpeg-2.5.4-32bit-static/ffmpeg
_TARGET_DIR=/var/www/html/epgrec/video/complete
_DEST_DIR=/mnt/ShareDisk/dlna/Movie/unclassified
_LOGFILE=/var/www/html/epgrec/log/`date +%Y%m%d`_do-ffmpeg.log
_FFMPEG_LOGFILE=/var/www/html/epgrec/log/`date +%Y%m%d`_$$_ffmpeg.log

_MP4_SIZE=1024x768
_CPU_CORES=$(/usr/bin/getconf _NPROCESSORS_ONLN)
_PRESET=/var/www/html/epgrec/libx264.ffpreset
#_PRESET=libx264.ffpreset

echo --------------------------------------
echo $1
echo --------------------------------------
_INPUT=$1
_OUTPUT=`echo ${_INPUT} | sed 's/.tmp.ts//'`

echo `date +'%Y/%m/%d %H:%M:%S'` "[I] EXEC [ ${_EXE_FFMPEG} ${_v} ]" >> ${_LOGFILE}
echo `date +'%Y/%m/%d %H:%M:%S'` "[I] EXEC [ ${_EXE_FFMPEG} ${_INPUT} ]" 

#%FFMPEG% -y -i %INPUT% -f mp4 -vcodec libx264 -r 30000/1001 -aspect 16:9 -s %MP4_SIZE% -bufsize 20000k -maxrate 25000k -vsync 1 -ac 2 -ar 48000 -ab 128k %OUTPUT%>> %FFMPEG_LOG_FILE% 2>&1
#${_EXE_FFMPEG} -y -i ${_INPUT} -f mp4 -vcodec libx264 -b 2000k \
#               -maxrate 2000k -threads 0 -r 30000/1001 -aspect 16:9 \
#               -s 1024x768 -vsync 1 -ac 2 -ar 48000 -ab 128k -async 100 \
#               ${_OUTPUT}

X264_HIGH_HDTV="-f mp4 -vcodec libx264 \
    -r 30000/1001 -aspect 16:9 -s ${_MP4_SIZE} \
    -bufsize 2000k -maxrate 25000k -ac 2 -ar 48000 \
    -ab 128k -threads ${_CPU_CORES} -filter_complex channelsplit"
    #-bufsize 20000k -maxrate 25000k -acodec libfaac -ac 2 -ar 48000 \
    #-b:v 300k -bufsize 1835k -maxrate 300k -minrate 300k -ac 2 -ar 44100 \
    #-map 0 -fpre ${_PRESET} \
    #-vpre ${_PRESET} \

X264_HIGH_HDTV_ASS="-f mp4 -vcodec libx264 \
    -r 30000/1001 -aspect 16:9 -s ${_MP4_SIZE} \
    -bufsize 2000k -maxrate 25000k -ac 2 -ar 48000 \
    -ab 128k -threads ${_CPU_CORES} -filter_complex channelsplit"
# -vf "${_OUTPUT}.ass

if [ -e "${_OUTPUT}.ass" ]; then
  echo `date +'%Y/%m/%d %H:%M:%S'` "[I] EXEC FFMPEG ASS MODE" >> ${_LOGFILE}
  echo `date +'%Y/%m/%d %H:%M:%S'` "[I] EXEC_FFMPEG,$$,${_INPUT} " >> ${_LOGFILE}
  echo `date +'%Y/%m/%d %H:%M:%S'` "[I] EXEC_FFMPEG $$ [ ${_EXE_FFMPEG} -y -i ${_INPUT} ${X264_HIGH_HDTV_ASS} ${_OUTPUT} ]" >> ${_LOGFILE}
  ${_EXE_FFMPEG} -y -i "${_INPUT}" ${X264_HIGH_HDTV_ASS} -vf "ass=${_OUTPUT}".ass "${_OUTPUT}" >> ${_FFMPEG_LOGFILE} 2>&1
else
  echo `date +'%Y/%m/%d %H:%M:%S'` "[I] EXEC_FFMPEG,$$,${_INPUT} " >> ${_LOGFILE}
  echo `date +'%Y/%m/%d %H:%M:%S'` "[I] EXEC_FFMPEG $$ [ ${_EXE_FFMPEG} -y -i ${_INPUT} ${X264_HIGH_HDTV} ${_OUTPUT} ]" >> ${_LOGFILE}
  ${_EXE_FFMPEG} -y -i "${_INPUT}" ${X264_HIGH_HDTV} "${_OUTPUT}" >> ${_FFMPEG_LOGFILE} 2>&1
fi

if [ $? -ne 0 ]; then
  echo `date +'%Y/%m/%d %H:%M:%S'` "[I] FFMPEG ERROR " >> ${_LOGFILE}
  exit 1
fi 

#${_EXE_FFMPEG} -y -i ${_INPUT} -f mp4 -vcodec libx264 -maxrate 2000k \
#               -threads 0 -r 30000/1001 -aspect 16:9 -s 1024x768 \
#               -bufsize 20000k -maxrate 25000k -vsync 1 -ac 2 -ar 48000 \
#               -ab 128k -async 100 ${_OUTPUT}

