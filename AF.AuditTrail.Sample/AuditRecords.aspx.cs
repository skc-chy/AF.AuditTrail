using Architecture.Foundation.AuditTrail;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AF.AuditTrail.Sample
{
    public partial class AuditRecords : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindAuditGrid();
        }

        protected void Audit_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdAudit.PageIndex = e.NewPageIndex;
            BindAuditGrid();
        }

        private void BindAuditGrid()
        {
            grdAudit.DataSource = AFAudit.GetAuditRecordList(new Guid("B40BCBDC-2B75-4E52-824B-093C5F1CD172"));
            grdAudit.DataBind();
        }

        protected void grdAudit_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            grdAuditDetail.DataSource = AFAudit.GetAuditTrailDataByAuditID(new Guid(e.CommandArgument.ToString()));
            grdAuditDetail.DataBind();
        }
    }
}