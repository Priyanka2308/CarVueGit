using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Utilities;
using Razoom.Model.Extension;

namespace carvue.purchase
{
    public partial class _default : PageBase
    {
        protected Razoom.Model.Job aJob
        {
            get
            {
                if (Request.QueryString["j"] == null)
                {
                    return null;
                }
                else
                {
                    String aJobID = Request.QueryString["j"];
                    return db.Jobs.FirstOrDefault(r => r.JobID == aJobID);
                }
            }
        }

        public object ExecuteScalar(String commandText, params System.Data.SqlClient.SqlParameter[] parameters)
        {
            var connection = db.Database.Connection;
            using (var command = connection.CreateCommand())
            {
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.CommandText = commandText;
                command.Parameters.AddRange(parameters);
                if (connection.State != System.Data.ConnectionState.Open) connection.Open();
                try
                {
                    return command.ExecuteScalar();
                }
                finally
                {
                    connection.Close();
                }
            }
        }

        protected override void bind()
        {
           
            search.type = "Purchases";
            search.bind();

            //int currentMonth = System.DateTime.UtcNow.Month;
            //int currentYear = System.DateTime.UtcNow.Year;
            //IEnumerable<IGrouping<DateTime, Razoom.Model.Item>> sAll = MyLocation.Purchases.Committed()
            //           .Where(a => a.PurchaseDate.FirstDayOfMonth() > System.DateTime.UtcNow.AddMonths(-6).FirstDayOfMonth()).SelectMany(f => f.Items)
            //           .Where(a => a.AllocationID == null && a.TaxGroupID != null && !a.Account.DefaultPayable && !a.Account.DefaultReceivable)
            //           .GroupBy(f => AuthDetail.AuthLocation.ConvertTimeFromUtc(f.Purchase.PurchaseDate).FirstDayOfMonth());

            //lDraft.Text = Razoom.Currency.Format(MyLocation.Purchases.Where(f => f.PurchaseDocument == null).SelectMany(f => f.Items).Sum(f => f.Total));

            //lPurchaseThisMonth.Text = Razoom.Currency.Format(MyLocation.Purchases.Committed().Where(w => w.AddedDate.Month == currentMonth && w.AddedDate.Year == currentYear)                
            //    .SelectMany(f => f.Items).Where(a => a.AllocationID == null && a.TaxGroupID != null && !a.Account.DefaultPayable && !a.Account.DefaultReceivable).Sum(g => g.Total));

            //lUnPaid.Text = Razoom.Currency.Format(Math.Abs(MyLocation.Purchases.Committed().Sum(f => f.Owed)));
            //lArrPurchase.Text = String.Join(", ", sAll.OrderBy(f => f.Key).Select(f => f.Sum(g => g.Total)).ToArray());            

            lDraft.Text = Razoom.Currency.Format(ExecuteScalar("GetPurchaseDraftTotal", new System.Data.SqlClient.SqlParameter("@locationId", AuthDetail.LocationID)));
            lPurchaseThisMonth.Text = Razoom.Currency.Format(ExecuteScalar("GetPurchaseMonthlyTotal", new System.Data.SqlClient.SqlParameter("@locationId", AuthDetail.LocationID)));
            lUnPaid.Text = Razoom.Currency.Format(ExecuteScalar("GetPurchaseUnpaidTotal", new System.Data.SqlClient.SqlParameter("@locationId", AuthDetail.LocationID)));
            lArrPurchase.Text = ExecuteScalar("GetPurchaseSixMonthTotal", new System.Data.SqlClient.SqlParameter("@locationId", AuthDetail.LocationID)).ToString();
            lUnPaidCredit.Text = Razoom.Currency.Format(ExecuteScalar("GetPurchaseCreditUnpaidTotal", new System.Data.SqlClient.SqlParameter("@locationId", AuthDetail.LocationID)));
        }
    }
}