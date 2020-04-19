# Gridpack_to_LHE_on_Condor
Produces LHE event on Condor from Madgraph gridpack

- It can produce lhe events from gridpack, please change the `pathName` , `folderName` and `fileName` in `gridpack_to_LHE_condor.sh` before running the code.
- run `voms-proxy-init --voms cms --valid 168:00` and submit via `condor_submit submit_condor.jdl`
