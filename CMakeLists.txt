project(test_superproject)

#--------------------------------------------------
# cmake old/new compatibility
#--------------------------------------------------
cmake_minimum_required(VERSION 2.8)

#--------------------------------------------------
# load script for checking out projects from git 
#--------------------------------------------------
include(${CMAKE_CURRENT_SOURCE_DIR}/CMake/GitExternal.cmake)

#--------------------------------------------------
# checkout common cmake tools library
# args are : location here, repo URL, repo branch
#--------------------------------------------------
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/CMake/common 
  https://github.com/biddisco/CMake.git 
  subproject
)

#--------------------------------------------------
# checkout projects we want to build together
#--------------------------------------------------
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/vmmlib 
  https://github.com/biddisco/vmmlib.git 
  subproject
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/lunchbox 
  https://github.com/biddisco/Lunchbox.git 
  subproject
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/collage 
  https://github.com/biddisco/Collage.git 
  subproject
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/dash 
  https://github.com/biddisco/dash.git 
  subproject
)
Git_External(
  ${CMAKE_CURRENT_SOURCE_DIR}/codash
  https://github.com/biddisco/codash.git 
  subproject
)
#--------------------------------------------------
# load add_subproject macro from common tools
#--------------------------------------------------
include(${CMAKE_CURRENT_SOURCE_DIR}/CMake/common/SubProject.cmake)

#--------------------------------------------------
# Add the subprojects to our project
# args are : project name in subproject, path from here
#--------------------------------------------------
add_subproject(vmmlib   vmmlib)
add_subproject(Lunchbox lunchbox)
add_subproject(Collage  collage)
add_subproject(dash     dash)
add_subproject(codash   codash)
