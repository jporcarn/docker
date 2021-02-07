using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using web_app.AdventureWorksInterop;

namespace web_app
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //init data source

            this.ObjectDataSource1.SelectMethod = "GetCustomers";
            this.ObjectDataSource1.TypeName = "web_app.AdventureWorksInterop.Sales";
        }

        protected void CustomersButton_Click(object sender, EventArgs e)
        {
            try
            {
                this.GridView1.DataSource = this.ObjectDataSource1;
                this.GridView1.DataBind();
            }
            catch (Exception ex)
            {
                this.ErrorLabel.Text = ex.Message;
                if (ex.InnerException != null)
                {
                    this.ErrorLabel.Text += $"\r\n{ex.InnerException.Message}";
                }
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine(e.NewPageIndex);

            this.GridView1.DataSource = this.ObjectDataSource1;
            this.GridView1.PageIndex = e.NewPageIndex;
            this.GridView1.DataBind();
        }
    }
}