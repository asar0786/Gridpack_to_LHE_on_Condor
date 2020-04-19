#!/bin/bash
echo "Starting job on " `date` #Date/time of start of job
echo "Running on: `uname -a`" #Condor job is running on this node
echo "System software: `cat /etc/redhat-release`" #Operating System on that node
source /cvmfs/cms.cern.ch/cmsset_default.sh  ## if a bash script, use .sh instead of .csh
export SCRAM_ARCH slc6_amd64_gcc530
eval `scramv1 project CMSSW CMSSW_9_3_16`
cd CMSSW_9_3_16/src/
echo "print pwd: "$PWD
eval `scramv1 runtime -sh` # cmsenv is an alias not on the workers
ls -lah
pathName=root://cmseos.fnal.gov//store/user/asahmed/Polarized/Mad_Pol/
#pathName=root://cmseos.fnal.gov//store/user/asahmed/Polarized/
echo $pathName
#folderName=WPhadWMlep
folderName=BW_Cut8
#folderName=Test
echo $folderName
fileName=aQGC_WPLhadWMLlepJJ_EWK_LO_NPle1_mjj100pt10_slc6_amd64_gcc630_CMSSW_9_3_16_tarball.tar.xz
echo $fileName
echo "==============Copying Files to src directory============="
xrdcp -f  $pathName/$folderName/$fileName .
#xrdcp -f  root://cmseos.fnal.gov//store/user/asahmed/Polarized/WPLhadWMLlp/aQGC_WPLhadWMLlepJJ_EWK_LO_NPle1_mjj100pt10_slc6_amd64_gcc630_CMSSW_9_3_16_tarball.tar.xz .
tar -xavf $fileName
./runcmsgrid.sh 5000 ${2} 8
#tar -xavf aQGC_WPLhadWMLlepJJ_EWK_LO_NPle1_mjj100pt10_slc6_amd64_gcc630_CMSSW_9_3_16_tarball.tar.xz
ls -lah
echo "Files in src after rungdrid.sh"
echo
ls -lah
echo "xrdcp -f cmsgrid_final.lhe $pathName/$folderName/cmsgrid_$folderName_${2}.lhe"
xrdcp -f cmsgrid_final.lhe $pathName/$folderName/WPLhadWMLlep_using_decaychain/cmsgrid_$folderName_${2}.lhe
#folderName=WPhadWMlep
#xrdcp -f event.lhe root://cmseos.fnal.gov//store/user/asahmed/Polarized/WPLhadWMLlep/event_${1}_${2}.lhe
cd ${_CONDOR_SCRATCH_DIR}
echo "End of the cmd"
date
