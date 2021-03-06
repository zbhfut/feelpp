###  TEMPLATE.txt.tpl; coding: utf-8 ---
#
#  Author(s): Christophe Prud'homme <christophe.prudhomme@feelpp.org>
#       Date: 2014-01-19
#
#  Copyright (C) 2011-2014 Feel++ Consortium
#
# Distributed under the GPL(GNU Public License):
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#
add_library( feelpp-applications-crb-benchmarkgrepl-options SHARED benchmarkgrepl-options.cpp )
target_link_libraries( feelpp-applications-crb-benchmarkgrepl-options ${FEELPP_LIBRARY} ${FEELPP_LIBRARIES} )
INSTALL(TARGETS feelpp-applications-crb-benchmarkgrepl-options DESTINATION lib/ COMPONENT Libs)
install(FILES benchmarkgrepl-options.hpp benchmarkgrepl-linear-elliptic.hpp benchmarkgrepl-nonlinear-elliptic.hpp DESTINATION include/feelpp/crb/BenchmarkGrepl COMPONENT Devel)
set(FEELPP_CRB_BenchmarkGrepl_LIBRARIES  feelpp-applications-crb-benchmarkgrepl-options PARENT_SCOPE)
set(FEELPP_CRB_LIBRARIES ${FEELPP_CRB_LIBRARIES} FEELPP_CRB_BenchmarkGrepl_LIBRARIES PARENT_SCOPE)

crb_add_library( benchmarkgrepl-linear-elliptic
  SRCS benchmarkgrepl-linear-elliptic.cpp
  LINK_LIBRARIES feelpp-applications-crb-benchmarkgrepl-options
  EXEC CRB_LIB_BENCHMARKGREPL_LINEAR_ELLIPTIC )

crb_add_library( benchmarkgrepl-nonlinear-elliptic-2d
  SRCS benchmarkgrepl-nonlinear-elliptic_inst2d.cpp
  LINK_LIBRARIES feelpp-applications-crb-benchmarkgrepl-options
  EXEC CRB_LIB_BENCHMARKGREPL_NONLINEAR_ELLIPTIC_2D )

crb_add_library( benchmarkgrepl-nonlinear-elliptic-3d
  SRCS benchmarkgrepl-nonlinear-elliptic_inst3d.cpp
  LINK_LIBRARIES feelpp-applications-crb-benchmarkgrepl-options
  EXEC CRB_LIB_BENCHMARKGREPL_NONLINEAR_ELLIPTIC_3D )


foreach(O 1 2 3)
  configure_file( benchmarkgrepl-linear-elliptic.xml.in ${CMAKE_CURRENT_SOURCE_DIR}/benchmarkgrepl-linear-elliptic${O}.xml.in COPYONLY )
  configure_file( benchmarkgrepl-linear-elliptic.cfg.in ${CMAKE_CURRENT_SOURCE_DIR}/benchmarkgrepl-linear-elliptic${O}.cfg )

  crb_add_model(
    benchmarkgrepl-linear-elliptic${O} BenchmarkGreplLinearElliptic CLASS BenchmarkGreplLinearElliptic<${O}>
    HDRS benchmarkgrepl-linear-elliptic.hpp LINK_LIBRARIES ${CRB_LIB_BENCHMARKGREPL_LINEAR_ELLIPTIC}
    CFG benchmarkgrepl-linear-elliptic${O}.cfg XML benchmarkgrepl-linear-elliptic${O}.xml )

  foreach(D 2 3)
    configure_file( benchmarkgrepl-nonlinear-elliptic.xml.in ${CMAKE_CURRENT_SOURCE_DIR}/benchmarkgrepl-nonlinear-elliptic${O}-${D}D.xml.in COPYONLY )
    configure_file( benchmarkgrepl-nonlinear-elliptic.cfg.in ${CMAKE_CURRENT_SOURCE_DIR}/benchmarkgrepl-nonlinear-elliptic${O}-${D}D.cfg )

    crb_add_model(
      benchmarkgrepl-nonlinear-elliptic${O}-${D}D BenchmarkGreplNonlinearElliptic CLASS BenchmarkGreplNonlinearElliptic<${O},${D}>
      HDRS benchmarkgrepl-nonlinear-elliptic.hpp LINK_LIBRARIES ${CRB_LIB_BENCHMARKGREPL_NONLINEAR_ELLIPTIC_${D}D}
      CFG benchmarkgrepl-nonlinear-elliptic${O}-${D}D.cfg XML benchmarkgrepl-nonlinear-elliptic${O}-${D}D.xml )
  endforeach()
endforeach()
crb_add_model(
  benchmarkgrepl-nonlinear-parabolic3 BenchmarkGreplNonLinearParabolic CLASS BenchmarkGreplNonLinearParabolic<3> 
  HDRS benchmarkgrepl-nonlinear-parabolic.hpp LINK_LIBRARIES ${FEELPP_LIBRARIES} CFG benchmarkgrepl-nonlinear-parabolic3.cfg XML benchmarkgrepl-nonlinear-parabolic3.xml )

feelpp_add_application(grepl_fem SRCS grepl_fem.cpp)
