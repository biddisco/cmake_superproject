cmake_superproject
==================

A demonstration project using cmake to build several other open source cmake based projects in one go.

The project consists of a set of simple rules to checkout several other projects (which may depend on each other)
and then build them as part of one larger cmake project. 
The superproject uses add_subdirectory(...) on each of the subprojects to produce a single top level project 
with each subproject as a subdirectory.

The project serves as a demonstration of how to setup projects so that they work well in the context of a larger superproject.
Problems which usually arise are the correct handling of findpackage(projectA) from project(B) (correct generation of
ProjectAConfig.cmake file and loading from B), passing of important #define settings from projectA to projectB and in turn 
passing to projectC loads (depends on) projectB, but does not load projectA.
 
This documentation is unfinished and will be extended (hopefully soon).

