//=============================================================================
//===	Copyright (C) 2001-2005 Food and Agriculture Organization of the
//===	United Nations (FAO-UN), United Nations World Food Programme (WFP)
//===	and United Nations Environment Programme (UNEP)
//===
//===	This program is free software; you can redistribute it and/or modify
//===	it under the terms of the GNU General Public License as published by
//===	the Free Software Foundation; either version 2 of the License, or (at
//===	your option) any later version.
//===
//===	This program is distributed in the hope that it will be useful, but
//===	WITHOUT ANY WARRANTY; without even the implied warranty of
//===	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
//===	General Public License for more details.
//===
//===	You should have received a copy of the GNU General Public License
//===	along with this program; if not, write to the Free Software
//===	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
//===
//===	Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
//===	Rome - Italy. email: GeoNetwork@fao.org
//==============================================================================

package org.openwis.metadataportal.services.metadata;

import jeeves.constants.Jeeves;
import jeeves.interfaces.Service;
import jeeves.server.ServiceConfig;
import jeeves.server.context.ServiceContext;

import org.fao.geonet.GeonetContext;
import org.fao.geonet.constants.Geonet;
import org.fao.geonet.kernel.search.ISearchManager;
import org.jdom.Element;
import org.openwis.metadataportal.services.common.json.AcknowledgementDTO;
import org.openwis.metadataportal.services.common.json.JeevesJsonWrapper;

//=============================================================================

/** Force rebuild index
  */

public class IndexRebuild implements Service {
   private ServiceConfig _config;

   //--------------------------------------------------------------------------
   //---
   //--- Init
   //---
   //--------------------------------------------------------------------------

   @Override
   public void init(String appPath, ServiceConfig config) throws Exception {
      _config = config;
   }

   //--------------------------------------------------------------------------
   //---
   //--- Service
   //---
   //--------------------------------------------------------------------------

   @Override
   public Element exec(Element params, ServiceContext context) throws Exception {
      boolean xlinks = false;

      String rebuildXLinkIndex = _config.getValue("rebuildxlinkindex");
      if (rebuildXLinkIndex != null) {
         xlinks = rebuildXLinkIndex.equals("yes");
      }

      GeonetContext gc = (GeonetContext) context.getHandlerContext(Geonet.CONTEXT_NAME);

      ISearchManager searchMan = gc.getSearchmanager();

      boolean info = searchMan.rebuildIndex(context, xlinks);

      Element elResp = new Element(Jeeves.Elem.RESPONSE);
      elResp.addContent(new Element("status").setText((info ? "true" : "false")));

      return JeevesJsonWrapper.send(new AcknowledgementDTO(true));
   };
}

//=============================================================================

