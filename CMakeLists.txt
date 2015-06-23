project(bbp-pv)

#--------------------------------------------------
# Setup some convenience flags depending on machine
#--------------------------------------------------
SET(COMPUTERNAME $ENV{COMPUTERNAME})
IF (COMPUTERNAME)
  SET(HOSTNAME $ENV{COMPUTERNAME})
ELSE(COMPUTERNAME)
  SET(HOSTNAME $ENV{HOSTNAME})
ENDIF (COMPUTERNAME)

#--------------------------------------------------
# Machines running OSMesa instead of OpenGL might need a larger threshold for image test comparisons
#--------------------------------------------------
set(IMAGE_THRESHOLD "0")

#--------------------------------------------------
# Some data paths which are machine dependent
#--------------------------------------------------
IF (HOSTNAME MATCHES "daint")
  set(MPI_FOUND ON CACHE BOOL "" FORCE)
  set(MPI_C_FOUND ON CACHE BOOL "" FORCE)
  set(MPI_CXX_FOUND ON CACHE BOOL "" FORCE)

  set(MPI_LIBRARIES /opt/cray/mpt/default/gni/mpich2-gnu/48/lib/libmpich.so CACHE STRING "" FORCE)
  set(MPI_C_LIBRARIES /opt/cray/mpt/default/gni/mpich2-gnu/48/lib/libmpich.so CACHE STRING "" FORCE)
  set(MPI_CXX_LIBRARIES /opt/cray/mpt/default/gni/mpich2-gnu/48/lib/libmpich.so CACHE STRING "" FORCE)

  set(MPI_INCLUDE_PATH /opt/cray/mpt/default/gni/mpich2-gnu/48/include CACHE PATH "" FORCE)
  set(MPI_C_INCLUDE_PATH /opt/cray/mpt/default/gni/mpich2-gnu/48/include CACHE PATH "" FORCE)
  set(MPI_CXX_INCLUDE_PATH /opt/cray/mpt/default/gni/mpich2-gnu/48/include CACHE PATH "" FORCE)

  set(MPI_C_COMPILER /opt/cray/craype/2.05/bin/cc CACHE STRING "" FORCE)
  set(MPI_CXX_COMPILER /opt/cray/craype/2.05/bin/CC CACHE STRING "" FORCE)
endif()

#--------------------------------------------------
# cmake policies
# see http://www.cmake.org/cmake/help/v2.8.12/cmake.html#section_Policies
#--------------------------------------------------
foreach(p
    CMP0003 CMP0017 CMP0023 CMP0042
    )
  if(POLICY ${p})
    cmake_policy(SET ${p} NEW)
  endif()
endforeach()

#--------------------------------------------------
# cmake old/new compatibility
#--------------------------------------------------
cmake_minimum_required(VERSION 2.8)

#--------------------------------------------------
# GitExternal config
#--------------------------------------------------
set(GIT_EXTERNAL_DISABLE_UPDATE ON)
set(GIT_EXTERNAL_USER_FORK "" CACHE STRING "Disabled")

#--------------------------------------------------
# load script for checking out projects from git
#--------------------------------------------------
include(${CMAKE_CURRENT_SOURCE_DIR}/CMake/GitExternal.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/CMake/common/SubProject.cmake)

#--------------------------------------------------
# checkout common cmake tools library
# args are : location here, repo URL, repo branch
#--------------------------------------------------
#Git_External(
#  ${CMAKE_CURRENT_SOURCE_DIR}/CMake/common
#  https://github.com/biddisco/CMake.git
#  master DUMMY
#)

#--------------------------------------------------
# checkout projects we want to build together
#--------------------------------------------------
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/vmmlib
#  https://github.com/biddisco/vmmlib.git
  https://github.com/Eyescale/vmmlib
  master DUMMY
  NO_UPDATE
  VERBOSE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/lunchbox
  git@github.com:Eyescale/Lunchbox.git
  master DUMMY
  NO_UPDATE
  VERBOSE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/collage
  git@github.com:Eyescale/Collage.git
  master DUMMY
  NO_UPDATE
  VERBOSE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/dash
  git@github.com:BlueBrain/dash.git
#  https://github.com/biddisco/dash.git
  master DUMMY
  NO_UPDATE
  VERBOSE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/codash
  git@github.com:BlueBrain/codash.git
# https://github.com/biddisco/codash.git
  master DUMMY
  NO_UPDATE
  VERBOSE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/bbptestdata
  ssh://biddisco@bbpcode.epfl.ch/common/TestData
  master DUMMY
  NO_UPDATE
  VERBOSE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/brion
  ssh://bbpcode.epfl.ch/common/Brion.git
  subproject DUMMY
  NO_UPDATE
  VERBOSE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/bbpsdk
  ssh://bbpcode.epfl.ch/common/BBPSDK.git
  master
  NO_UPDATE
  VERBOSE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/displaycluster
  git@github.com:biddisco/DisplayCluster.git
  subproject
  NO_UPDATE DUMMY
  VERBOSE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/flatbuffers
  git@github.com:BlueBrain/flatbuffers.git
  master DUMMY
  VERBOSE
  NO_UPDATE
)

Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/zeq
  https://github.com/HBPVIS/zeq.git
  master DUMMY
  VERBOSE
  NO_UPDATE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/pv-cuda-piston
  git@github.com:biddisco/pv-cuda-piston.git
  pv-4.4 DUMMY
  VERBOSE
#  NO_UPDATE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/pv-zoltan
  git@github.com:biddisco/pv-zoltan.git
  pv-4.4 DUMMY
  VERBOSE
#  NO_UPDATE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/pv-meshless
  git@github.com:biddisco/pv-meshless.git
  pv-4.4 DUMMY
  VERBOSE
#  NO_UPDATE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/pv-astro
  git@github.com:biddisco/pv-astro.git
  master DUMMY
  VERBOSE
#  NO_UPDATE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/pv-MIP
  git@github.com:biddisco/pv-MIP.git
  master DUMMY
  VERBOSE
#  NO_UPDATE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/pv-temporal
  git@github.com:biddisco/pv-temporal.git
  master DUMMY
  VERBOSE
#  NO_UPDATE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/pv-bbp
  ela.cscs.ch:/users/biddisco/gitrepos/parabbp
  pv-4.4 DUMMY
  VERBOSE
#  NO_UPDATE
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/pv-splotch
  git+ssh://biddisco@scm.hpcforge.org/var/lib/gforge/chroot/scmrepos/git/pv-splotch/pv-splotch.git
  pv-4.4
  VERBOSE
#  NO_UPDATE
)

#--------------------------------------------------
# Testing : Include the standard testing module
#--------------------------------------------------
include(CTest)
include(Dart)

#--------------------------------------------------
# load add_subproject macro from common tools
#--------------------------------------------------
include(${CMAKE_CURRENT_SOURCE_DIR}/CMake/common/SubProject.cmake)

#--------------------------------------------------
# Setup Output directories
#--------------------------------------------------
SET (CMAKE_RUNTIME_OUTPUT_DIRECTORY
    ${PROJECT_BINARY_DIR}/bin CACHE PATH "Single Directory for all Executables."
)
SET (CMAKE_LIBRARY_OUTPUT_DIRECTORY
    ${PROJECT_BINARY_DIR}/bin CACHE PATH "Single Directory for all Libraries"
)
SET (CMAKE_ARCHIVE_OUTPUT_DIRECTORY
    ${PROJECT_BINARY_DIR}/bin CACHE PATH "Single Directory for all static libraries."
)

#--------------------------------------------------
# Add the subprojects to our project
# args are : project name in subproject, path from here
#--------------------------------------------------
add_subproject(vmmlib      vmmlib)
add_subproject(Lunchbox    lunchbox)
add_subproject(Collage     collage)
add_subproject(dash        dash)
add_subproject(codash      codash)
add_subproject(BBPTestData bbptestdata)
add_subproject(Brion       brion)
add_subproject(BBPSDK      bbpsdk)
add_subproject(FlatBuffers flatbuffers)
add_subproject(zeq         zeq)

set(pv_temporal_SKIP_FIND 1)
set(pv_astro_SKIP_FIND 1)
set(pv_MIP_SKIP_FIND 1)
set(pv_splotch_SKIP_FIND 1)
set(pv_bbp_SKIP_FIND 1)
set(pv_zeq_SKIP_FIND 1)

add_subproject(pv_zoltan      pv-zoltan)
add_subproject(pv_cuda_piston pv-cuda-piston)
add_subproject(pv_temporal    pv-temporal)
add_subproject(pv_astro       pv-astro)
add_subproject(pv_MIP         pv-MIP)
add_subproject(pv_meshless    pv-meshless)
add_subproject(pv_splotch     pv-splotch/paraview)
add_subproject(pv_bbp         pv-bbp)
#ADD_SUBPROJECT(DSM-Manager    "Icarus/DSMManager")
