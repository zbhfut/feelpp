# -*- mode: cmake; coding: utf-8 -*-
#
#  Author(s): Christophe Prud'homme <christophe.prudhomme@feelpp.org>
#       Date: 2009-11-29
#
#  Copyright (C) 2009-2012 Université Joseph Fourier (Grenoble I)
#  Copyright (C) 2011-2016 Feel++ Consortium
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
set_directory_properties(PROPERTIES EXCLUDE_FROM_ALL TRUE)
INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_SOURCE_DIR} )

add_subdirectory(python)

if( FEELPP_HAS_GMSH )
if (NOT FEELPP_MINIMAL_CONFIGURATION)
  foreach(DIR laplacian
      stokes
      stokes_1D
      advection
      accoustic
      dd
      heat
      solid
      ns
      heatns
      nonlinear
      adapt
      nirb
      fd
      maxwell
      opt
      eikonal
      eigen
      magnetostatic
      hdg )
    add_subdirectory(${DIR})
  endforeach()
endif()
endif()
