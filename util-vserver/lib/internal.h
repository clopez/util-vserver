// $Id$    --*- c++ -*--

// Copyright (C) 2003 Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
//  
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; version 2 of the License.
//  
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//  
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


#ifndef H_UTIL_VSERVER_LIB_INTERNAL_H
#define H_UTIL_VSERVER_LIB_INTERNAL_H

#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

size_t		utilvserver_uint2str(char *buf, size_t len,
				     unsigned int val, unsigned char base);
size_t		utilvserver_int2str(char *buf, size_t len,
				    signed int val, unsigned char base);
int		utilvserver_checkCompatVersion();

#ifdef __cplusplus
}
#endif


#endif	//  H_UTIL_VSERVER_LIB_INTERNAL_H
