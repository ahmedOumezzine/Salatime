using System;
using System.ComponentModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;

namespace SalatimeV1.version1
{
    [ToolboxItemAttribute(false)]
    public class version1 : WebPart
    {
        // Visual Studio might automatically update this path when you change the Visual Web Part project item.
        private const string _ascxPath = @"~/_CONTROLTEMPLATES/15/SalatimeV1/version1/version1UserControl.ascx";

        protected override void CreateChildControls()
        {
            version1UserControl control = (version1UserControl)Page.LoadControl(_ascxPath);
            control.myconfig = this;
            Controls.Add(control);
        }
        [Category("google map")]
        [WebBrowsable(true)]
        [WebDescription("longitude ")]
        [WebDisplayName("longitude ")]
        [Personalizable(PersonalizationScope.Shared)]
        public string longitude { get; set; }

        [Category("google map")]
        [WebBrowsable(true)]
        [WebDescription("latitude  ")]
        [WebDisplayName("latitude ")]
        [Personalizable(PersonalizationScope.Shared)]
        public string latitude { get; set; }
    }
}
