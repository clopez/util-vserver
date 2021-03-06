// $Id$    --*- c -*--

// Copyright (C) 2007 Daniel Hokka Zakrisson
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


#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif

static inline ALWAYSINLINE int
vc_net_remove_netv2(nid_t nid, struct vc_net_addr const *info)
{
  if (info->vna_type == VC_NXA_TYPE_ANY) {
    struct vcmd_net_addr_ipv4_v1	k_ipv4;
    struct vcmd_net_addr_ipv6_v1	k_ipv6;
    int					ret;

    k_ipv4.type = VC_NXA_TYPE_ANY;
    k_ipv6.type = VC_NXA_TYPE_ANY;

    ret = vserver(VCMD_net_remove_ipv6, NID_USER2KERNEL(nid), &k_ipv6);
    if (ret == -1 && errno != ENOSYS)
      return -1;
    return vserver(VCMD_net_remove_ipv4_v1, NID_USER2KERNEL(nid), &k_ipv4);
  }
  switch (info->vna_type & (VC_NXA_TYPE_IPV4 | VC_NXA_TYPE_IPV6)) {
    case VC_NXA_TYPE_IPV4: {
      struct vcmd_net_addr_ipv4_v1	k_info;

      k_info.type        = info->vna_type & ~VC_NXA_TYPE_IPV4;
      k_info.flags       = info->vna_flags;
      k_info.ip.s_addr   = info->vna_v4_ip.s_addr;
      k_info.mask.s_addr = info->vna_v4_mask.s_addr;

      return vserver(VCMD_net_remove_ipv4_v1, NID_USER2KERNEL(nid), &k_info);
    }
    case VC_NXA_TYPE_IPV6: {
      struct vcmd_net_addr_ipv6_v1	k_info;

      k_info.type          = info->vna_type & ~VC_NXA_TYPE_IPV6;
      k_info.flags         = info->vna_flags;
      k_info.prefix        = info->vna_prefix;
      memcpy(k_info.ip.s6_addr, info->vna_v6_ip.s6_addr, sizeof(struct in6_addr));
      memcpy(k_info.mask.s6_addr, info->vna_v6_mask.s6_addr, sizeof(struct in6_addr));

      return vserver(VCMD_net_remove_ipv6, NID_USER2KERNEL(nid), &k_info);
    }
    default:
      errno = EINVAL;
      return -1;
  }
}
