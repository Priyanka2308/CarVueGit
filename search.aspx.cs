using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using Razoom.Model;

namespace carvue.purchase
{
    public partial class _search : PageBase
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);          
        }


        void lSearch_Click(object sender, EventArgs e)
        {
            
        }

        protected override void bind()
        {
            ddlType.Items.Insert(0, new ListItem(String.Empty, String.Empty));
            search.type = "purchases";
            search.bind();
        }

    }
}