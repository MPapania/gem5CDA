#!/usr/bin/env bash

# setup variables
# gem5 directory
gemDir=../gem5
linuxDir=../linux_armv7

# check to make sure the gem5 directory is there
if [[ ! -e $gemDir ]]; then
  echo "GEM 5 directory is missing!"
  exit;
fi

# check to make sure the linux directory is there
if [[ ! -e $linuxDir ]]; then
  echo "GEM 5 directory is missing!"
  exit;
fi

# set Absolute M5_PATH directory
cd $linuxDir
absM5Path=$PWD

# check if M5_PATH is set
if [[ -z $M5_PATH ]]; then
 echo "You need to set your M5_PATH variable to the linux folder: $absM5Path"
 echo "Run the following command: export M5_PATH=$absM5Path"
 cd -
 exit
fi

cd -

# Go to gem5 directory
echo "cd to $gemDir"
cd $gemDir

# output directory for simulation
outputDir=simOutput
# check to make sure the output directory is there
if [[ ! -e $outputDir ]]; then
  echo "Creating output directory"
  mkdir $outputDir
fi

benchmarkOutputDir=$outputDir/bodytrack
# check to make sure the output directory is there
if [[ ! -e $benchmarkOutputDir ]]; then
  echo "Creating output directory"
  mkdir $benchmarkOutputDir
fi

# Checkpoint directory
cpDir=$outputDir/checkpoints
# check to make sure the output directory is there
if [[ ! -e $cpDir ]]; then
  echo "Creating output directory"
  mkdir $cpDir
fi

#DO NOT EDIT THIS. THIS IS THE NAME OF THE GEM5 stats output
statsFilename=stats.txt 
# variable used to do the file name rotation
var=1

NUM_ITERATIONS=1
for ((i = 0; i < $NUM_ITERATIONS; i++)) do 
 
 # find an unused filename
if [[ -e $benchmarkOutputDir/$statsFilename ]]; then
   while [[ -e $benchmarkOutputDir/$statsFilename$var ]]; do
         ((var++))
         done
   # rename the previous file
   echo "Backing up previous stats file: $benchmarkOutputDir/$statsFilename"
   mv $benchmarkOutputDir/$statsFilename $benchmarkOutputDir/$statsFilename$var
fi

# BEGIN MAIN PORTION OF SCRIPT
   #echo $i > $benchmarkOutputDir/$statsFilename
   
#    ./build/ARM/gem5.opt -d $benchmarkOutputDir configs/example/fs.py --disk-image=/home/marlon/CDA5106/aarch-system-20170616/disks/linux-aarch32-ael.img --dtb=/home/marlon/CDA5106/aarch-system-20170616/binaries/armv7_gem5_v1_1cpu.20170616.dtb --kernel=/home/marlon/CDA5106/aarch-system-20170616/binaries/vmlinux.vexpress_gem5_v1.20170616 --cpu-type=O3_ARM_v7a_3 --cpu-clock=2GHz --mem-size=1024MB --ruby --caches --checkpoint-dir=checkpoints --num-l3caches=0 --l2cache --machine-type=VExpress_GEM5_V1

    ./build/ARM/gem5.opt -d $benchmarkOutputDir configs/example/fs.py --disk-image=$M5_PATH/disks/expanded-linux-aarch32-ael.img --dtb=$M5_PATH/binaries/armv7_gem5_v1_1cpu.20170616.dtb --kernel=$M5_PATH/binaries/vmlinux.vexpress_gem5_v1.20170616 --cpu-type=O3_ARM_v7a_3 --cpu-clock=2GHz --mem-size=1024MB --ruby --caches --checkpoint-dir=$cpDir --num-l3caches=0 --l2cache --machine-type=VExpress_GEM5_V1
done
 




