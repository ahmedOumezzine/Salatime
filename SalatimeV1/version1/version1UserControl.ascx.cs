using Microsoft.SharePoint;
using Microsoft.SharePoint.WebPartPages;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace SalatimeV1.version1
{
    public partial class version1UserControl : UserControl
    {
        public version1 myconfig { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lng.Value = myconfig.longitude;
                lat.Value = myconfig.latitude;
            }
            if (SPContext.Current.Web.CurrentUser.ID == SPContext.Current.Web.Site.SystemAccount.ID)
            {
                Search.Visible = true;
                btnSubmit.Visible = true;
            }
            else
            {
                Search.Visible = false;
                btnSubmit.Visible = false;
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            myconfig.longitude = lng.Value;
            myconfig.latitude = lat.Value; 
            
            SPWeb web = SPContext.Current.Web;
            SPFile file = web.GetFile(HttpContext.Current.Request.Url.ToString());
            SPLimitedWebPartManager manager = file.GetLimitedWebPartManager(PersonalizationScope.Shared);
            foreach( System.Web.UI.WebControls.WebParts.WebPart webPart in manager.WebParts)
            {
                if (webPart.Title == "SalatimeV1 - version1")
                {
                    ((version1)webPart).longitude =  myconfig.longitude;
                    ((version1)webPart).latitude = myconfig.latitude;
 
                    try
                    {
                        web.AllowUnsafeUpdates = true;
                        manager.SaveChanges(webPart);
                    }
                    finally
                    {
                        web.AllowUnsafeUpdates = false;
                    }
                }
            }
            
            
        }
    }
 
 }

