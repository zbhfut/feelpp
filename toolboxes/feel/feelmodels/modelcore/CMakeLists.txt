#############################################################################

SET(FEELPP_MODELS_OPTIONS_NUMBER_OF_PARAMETERS "10" CACHE STRING "number of parameters" )
SET(FEELPP_MODELS_OPTIONS_NUMBER_OF_GEOPARAMETERS "10" CACHE STRING "number of geometric parameters" )
SET(FEELPP_MODELS_OPTIONS_NUMBER_OF_GINACEXPR "10" CACHE STRING "number of ginac expr" )

CONFIGURE_FILE( ${CMAKE_CURRENT_SOURCE_DIR}/feelmodelscoreconstconfig.hpp.in ${CMAKE_CURRENT_BINARY_DIR}/feelmodelscoreconstconfig.hpp )
INSTALL( FILES ${CMAKE_CURRENT_BINARY_DIR}/feelmodelscoreconstconfig.hpp DESTINATION include/feelpp/toolboxes/feel/feelmodels/modelcore COMPONENT Devel)

INSTALL(FILES ${CMAKE_CURRENT_SOURCE_DIR}/feelpp.models.macros.cmake DESTINATION share/feelpp/toolboxes/cmake/modules COMPONENT Devel)

set(FEELPP_MODELS_LIBBASE_CHECK_DIR "${CMAKE_CURRENT_BINARY_DIR}/checkmodelsbuilt" CACHE STRING "FEELPP_MODELS_LIBBASE_CHECK_DIR")
file(REMOVE_RECURSE ${FEELPP_MODELS_LIBBASE_CHECK_DIR})


#############################################################################
#############################################################################

add_library(feelpp_modelcore
  SHARED
  options.cpp log.cpp timertool.cpp
  modelbase.cpp modelalgebraic.cpp modelnumerical.cpp
  markermanagement.cpp modelmeasures.cpp
  )
target_link_libraries(feelpp_modelcore ${FEELPP_LIBRARY} ${FEELPP_LIBRARIES})
set_property(TARGET feelpp_modelcore PROPERTY MACOSX_RPATH ON)
if( FEELPP_ENABLE_PCH_MODELS )
    add_precompiled_header( feelpp_modelcore )
endif()
INSTALL(TARGETS feelpp_modelcore DESTINATION lib/ COMPONENT Libs)
FILE(GLOB files "*.hpp")
INSTALL(FILES ${files} DESTINATION include/feelpp/toolboxes/feel/feelmodels/modelcore COMPONENT Devel)

include(feelpp.models.macros.cmake)
