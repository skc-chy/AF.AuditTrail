﻿using System;
using System.Web.UI;

namespace SampleApplication
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Lnk_Click(Object sender, EventArgs e)
        {
            Response.Redirect("AuditTrailDemo.aspx");
        }
    }
}
