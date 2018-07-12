using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using Razoom.Model;
using System.Data.Entity.Validation;
using System.Data.Entity;
using System.Threading.Tasks;
using Utilities;
using Razoom.Model.Extension;
using Razoom.Model.Contract;
using Razoom.Model.Interfaces;
using System.Web.UI.HtmlControls;
using Razoom.Model.Extension.Decorator;

namespace carvue.shared
{
    public partial class edit : PageBase
    {
        public string aPurchaseId
        {
            get
            {
                if (Request.QueryString["p"] == null)
                {
                    return null;
                }
                else
                {
                    return Request.QueryString["p"];
                }
            }
        }

        bool isWarningEdit = false;
        bool isWarningEditStock = false;
        protected Razoom.Model.Stock aStock
        {
            get
            {
                if (Request.QueryString["s"] == null)
                {
                    return null;
                }
                else
                {
                    String aStockID = Request.QueryString["s"];
                    hfStockID.Value = aStockID;
                    ViewState["StockID"] = aStockID;
                    return db.Stocks
                        .Include(c => c.Vehicle)
                        .FirstOrDefault(r => r.StockID == aStockID);
                }
            }
        }

        protected Razoom.Model.TaxGroup aTaxGroup
        {
            get
            {
                if (Request.QueryString["tg"] == null)
                {
                    return null;
                }
                else
                {
                    String aStockID = Request.QueryString["tg"];
                    return MyLocation.TaxGroups.FirstOrDefault(r => r.TaxGroupID == aStockID);
                }
            }
        }

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
                    ViewState["JobID"] = aJobID;
                    hfJobID.Value = aJobID;
                    return db.Jobs
                        .Include(c => c.Contact)
                        .Include(c => c.Vehicle)
                        .FirstOrDefault(r => r.JobID == aJobID);
                }
            }
        }

        protected Razoom.Model.Purchase _Purchase = null;
        protected Razoom.Model.Purchase aPurchase
        {
            get
            {
                if (_Purchase != null)
                    return _Purchase;
                if (Request.QueryString["p"] == null)
                {
                    return null;
                }
                else
                {
                    String aPurchaseID = Request.QueryString["p"];
                    _Purchase = db.Purchases
                        .Include(c => c.Contact)
                        .Include(c => c.Contact.ContactMethods)
                        .Include(c => c.Contact.pCountry)
                        .Include(c => c.AddedUser)
                        .Include(c => c.PurchaseDocument)
                        .Include(c => c.IntegrationLocationPurchases.Select(f => f.Integration.IntegrationLocations))
                        .Include(c => c.PurchaseTransactionType)
                        .Include(c => c.Notes.Select(f => f.NoteType))
                        .Include(c => c.Stock)
                        .Include(c => c.Job)
                        .Include(c => c.Location.Container)
                        .Include(c => c.Location.Timezone)
                        .Include(c => c.Location.Currency)
                        .FirstOrDefault(r => r.PurchaseID == aPurchaseID && r.LocationID == MyLocation.LocationID);
                    return _Purchase;
                }
            }
            set
            {
                _Purchase = value;
            }
        }

        public string aContactID
        {
            get
            {
                if (Request.QueryString["contactid"] == null)
                {
                    return null;
                }
                else
                {
                    return Request.QueryString["contactid"];
                }
            }
        }

        protected Razoom.Model.Contact _aContact = null;
        protected Razoom.Model.Contact aContact
        {
            get
            {
                if (_aContact == null)
                {
                    if (Request.QueryString["contactid"] == null || hfContactID.Value == null)
                    {
                        return null;
                    }
                    else
                    {
                        string aContactID = Request.QueryString["contactid"];
                        hfContactID.Value = aContactID;
                        _aContact = db.Contacts.FirstOrDefault(r => r.ContactID == aContactID);
                        return db.Contacts.FirstOrDefault(r => r.ContactID == aContactID);
                    }
                }
                else
                    return _aContact;
            }
            set
            {
                _aContact = value;
            }
        }
        protected Razoom.Model.Account _aAccount = null;
        protected Razoom.Model.Account aAccount
        {
            get
            {
                if (Request.QueryString["a"] == null) return null;
                else
                {
                    string id = Request.QueryString["a"];
                    return db.Accounts.FirstOrDefault(f => f.AccountID == id);
                }
            }
        }

        protected Razoom.Model.PurchaseTransactionType _PurchaseTransactionType = null;
        protected Razoom.Model.PurchaseTransactionType PurchaseTransactionType
        {
            get
            {
                if (aPurchase == null)
                {

                    if (Request.QueryString["ptt"] != null && _PurchaseTransactionType == null)
                    {
                        String PurchaseTransactionTypeID = Request.QueryString["ptt"].ToString();
                        _PurchaseTransactionType = db.PurchaseTransactionTypes.FirstOrDefault(r => r.PurchaseTransactionTypeID == PurchaseTransactionTypeID);
                    }

                    return _PurchaseTransactionType;
                }
                else
                    return aPurchase.PurchaseTransactionType;
            }
            set
            {
                _PurchaseTransactionType = value;
            }
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            db.Configuration.LazyLoadingEnabled = false;
            bAdd.Click += new EventHandler(bAdd_Click);
            lbSavePurchase.Click += lbSavePurchase_Click;
            lbDeleteJob.Click += lbDeleteJob_Click;
            lbDeleteStock.Click += lbDeleteStock_Click;
            rs.ItemDataBound += rs_ItemDataBound;
            rs.ItemCommand += rs_ItemCommand;
            rPayment.ItemDataBound += rPayment_ItemDataBound;
            rOffset.ItemDataBound += rOffset_ItemDataBound;
            bAction.Click += bAction_Click;
            bPayment.Click += bPayment_Click;
            bDelete.Click += bDelete_Click;
            lbEdit.Click += lbEdit_Click;
            bEmailCust.Click += bEmailCust_Click;
            lbsendEmail.Click += lbsendEmail_Click;
            db.AcademyMediaPurchase_Added += db_AcademyMediaPurchase_Added;
            rQNotes.ItemDataBound += rQNotes_ItemDataBound;
            rAccountIntegration.ItemDataBound += rAccountIntegration_ItemDataBound;
            lbReGen.Click += lbReGen_Click;
            btnEditLineItem.Click += btnEditLineItem_Click;
            btnDeleteLineItem.Click += btnDeleteLineItem_Click;
        }

        private void btnEditLineItem_Click(object sender, EventArgs e)
        {
            Razoom.Model.Item itemId = db.Items.Find(Int32.Parse(hiddenItemID.Value));
            List<Razoom.Model.Item> aItemPurchaseId = new List<Razoom.Model.Item>();
            aItemPurchaseId = db.Items.Where(a => a.PurchaseID == aPurchaseId).OrderBy(x => x.AddedDate).ToList();
            DateTime transactionDate = DateTime.Now;

            try
            {
                foreach (var item in aItemPurchaseId)
                {
                        if (item.ItemID == itemId.ItemID)
                        {
                            Razoom.Model.ItemTransaction itmTransaction = db.ItemTransactions.Where(w => w.ItemID == itemId.ItemID).FirstOrDefault();
                            string lineItemId = hiddenItemID.Value;

                            if (itmTransaction != null)
                            {
                                itmTransaction.AccountID = dAccEdit.SelectedValue;
                                itmTransaction.Item.TaxGroupID = dTaxEdit.SelectedValue;
                            }

                            itemId.TaxGroupID = dTaxEdit.SelectedValue;
                            itemId.AccountID = dAccEdit.SelectedValue;
                            itemId.Quantity = !string.IsNullOrEmpty(tbQtyEdit.Text) ? Convert.ToDecimal(tbQtyEdit.Text) : 0;
                            itemId.UpdatedUserID = AuthDetail.User.UserID;
                            itemId.UpdatedDate = transactionDate;

                            if (aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.Purchase)
                            {
                                itemId.Value = (!string.IsNullOrEmpty(tbValEdit.Text) ? Convert.ToDecimal(tbValEdit.Text) : 0);
                            }
                            else
                            {
                                itemId.Value = (!string.IsNullOrEmpty(tbValEdit.Text) ? Convert.ToDecimal(tbValEdit.Text) : 0) * -1;
                            }

                            itemId.Description = tService.Text;
                            updateMessage(true, "updated");
                            SaveChanges();
                            bindItems();

                            string itemNet = aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit ? Razoom.Currency.Format(item.Net * -1) : Razoom.Currency.Format(item.Net);
                            string itemTax = aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit ? Razoom.Currency.Format(item.Tax * -1) : Razoom.Currency.Format(item.Tax);
                            List<Razoom.Model.ItemTransaction> aItemTransactionlist = new List<Razoom.Model.ItemTransaction>();
                            aItemTransactionlist = db.ItemTransactions.Where(x => x.ItemID == item.ItemID).OrderBy(x => x.AddedDate).ToList();

                            if (aItemTransactionlist.Count > 0)
                            {
                                if (aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.Purchase)
                                {
                                    aItemTransactionlist[0].Value = Convert.ToDecimal(itemNet);
                                    aItemTransactionlist[0].TransactionDate = transactionDate;
                                    aItemTransactionlist[1].Value = Convert.ToDecimal(itemTax);
                                    aItemTransactionlist[1].TransactionDate = transactionDate;
                                    item.UpdatedUserID = AuthDetail.User.UserID;
                                    item.Purchase.UpdatedDate = transactionDate;
                                }
                                else
                                {
                                    aItemTransactionlist[0].Value = Convert.ToDecimal(itemNet) * -1;
                                    aItemTransactionlist[0].TransactionDate = transactionDate;
                                    aItemTransactionlist[1].Value = Convert.ToDecimal(itemTax) * -1;
                                    aItemTransactionlist[1].TransactionDate = transactionDate;
                                    item.UpdatedUserID = AuthDetail.User.UserID;
                                    item.Purchase.UpdatedDate = transactionDate;
                                }

                                SaveChanges();
                                bindItems();
                            }
                        }
                        else
                        {
                            if (item.Value < 0 && aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.Purchase)
                            {
                                item.Value = Convert.ToDecimal(lTot.Text) * -1;
                                Razoom.Model.ItemTransaction itemTransaction = db.ItemTransactions.Where(x => x.ItemID == item.ItemID).First();
                                itemTransaction.Value = item.Value;
                                itemTransaction.TransactionDate = transactionDate;
                                item.UpdatedUserID = AuthDetail.User.UserID;
                                item.Purchase.UpdatedDate = transactionDate;
                                SaveChanges();
                                bindItems();
                            }

                            if (item.Value > 0 && aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit)
                            {
                                item.Value = Convert.ToDecimal(lTot.Text);
                                Razoom.Model.ItemTransaction itemTransaction = db.ItemTransactions.Where(x => x.ItemID == item.ItemID).First();
                                itemTransaction.Value = item.Value;
                                itemTransaction.TransactionDate = transactionDate;
                                item.UpdatedUserID = AuthDetail.User.UserID;
                                item.Purchase.UpdatedDate = transactionDate;
                                SaveChanges();
                                bindItems();
                            }
                        }
                    }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        void lbReGen_Click(object sender, EventArgs e)
        {
            aPurchase.reSaveDocument(db, AuthDetail.User, AuthDetail.Location, aPurchase.Committed, chkVDecl.Checked);
        }

        void rAccountIntegration_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.DataItem is Razoom.Model.Interfaces.IIntegrationLocation<Purchase>)
            {
                Razoom.Model.Interfaces.IIntegrationLocation<Purchase> IntegrationLocation = (Razoom.Model.Interfaces.IIntegrationLocation<Purchase>)e.Item.DataItem;
                System.Web.UI.HtmlControls.HtmlAnchor aAccountIntegration = (System.Web.UI.HtmlControls.HtmlAnchor)e.Item.FindControl("aAccountIntegration");
                aAccountIntegration.InnerHtml = String.Format("<i class=\"logo logo-{0}-24\"></i>", IntegrationLocation.Integration.Name.ToLower());
                aAccountIntegration.HRef = IntegrationLocation.Link;
                if (!String.IsNullOrEmpty(IntegrationLocation.ErrorID))
                {
                    aAccountIntegration.InnerHtml += "<i class=\"logo-error-24\"></i>";
                }
            }
        }

        void rQNotes_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.DataItem is Razoom.Model.QuickNote)
            {
                Razoom.Model.QuickNote Item = (Razoom.Model.QuickNote)(e.Item.DataItem);
                Literal lQnote = (Literal)e.Item.FindControl("lQnote");
                lQnote.Text = string.Format("<span class='label tag round ellipsis secondary'><a href='javascript:;' class='grey qnTag' title=\"{1}\">{0}</a></span>", Item.Name, Item.Detail);
            }
        }

        private bool MediaPurchaseAdded = false;
        void db_AcademyMediaPurchase_Added(Razoom.Model.MediaPurchase MediaPurchase)
        {
            if (MediaPurchase != null)
                MediaPurchaseAdded = true;
        }

        void bDelete_Click(object sender, EventArgs e)
        {
            Boolean Deleted = false;
            try
            {
                db.Entry<Purchase>(this.aPurchase).Collection<IntegrationLocationPurchase>(f => f.IntegrationLocationPurchases).Load();
                this.aPurchase.loadItems(db);
                Razoom.Model.Interfaces.IPurchase Purchase = aPurchase;
                if (Purchase.IntegrationLocationPurchases.Where(f => f.Integration.IntegrationTypeID == Razoom.Model.IntegrationType.Account).Any())
                {
                    Purchase = new Razoom.Model.Extension.Map.Accounting.PurchaseAccountingIntegrationDecorator(Purchase, AccountingProcessor);
                }
                ICommitItemContainer purchaseDelete = Purchase;
                if (aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit)
                {
                    purchaseDelete = new CommitItemContainerDeleteIncrementInventoryDecorator(Purchase);
                }

                else
                {
                    purchaseDelete = new CommitItemContainerDeleteDecreaseInventoryDecorator(Purchase);
                }

                Deleted = purchaseDelete.delete(db, AuthDetail.User, AuthDetail.Location);
            }
            catch (Exception ex)
            {
                updateMessage(false, "faileddelete");
                LogError(ex);
            }
            if (Deleted)
                Response.Redirect("~/Purchase/Default.aspx", true);

            else updateMessage(false, "faileddelete");
        }

        void rPayment_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.DataItem is Razoom.Model.Item)
            {
                Razoom.Model.Item Item = (Razoom.Model.Item)(e.Item.DataItem);
                if (Item.Payment != null)
                {
                    Literal lPayDate = (Literal)e.Item.FindControl("lPayDate");
                    Literal lDe = (Literal)e.Item.FindControl("lDe");
                    Literal lA = (Literal)e.Item.FindControl("lA");
                    Literal lRef = (Literal)e.Item.FindControl("lRef");
                    Literal lTotal = (Literal)e.Item.FindControl("lTotal");
                    Literal lAddedBy = (Literal)e.Item.FindControl("lAddedBy");
                    Literal lAddedDate = (Literal)e.Item.FindControl("lAddedDate");
                    System.Web.UI.HtmlControls.HtmlAnchor aAccountIntegrationPayment = (System.Web.UI.HtmlControls.HtmlAnchor)e.Item.FindControl("aAccountIntegrationPayment");

                    lPayDate.Text = String.Format("{0:d}", AuthDetail.AuthLocation.ConvertTimeFromUtc(Item.Payment.Date));
                    switch (Item.Description.ToLower())
                    {
                        case "online": lDe.Text = Razoom.Resources.forms.Forms.online; break;
                        case "bacs": lDe.Text = Razoom.Resources.forms.Forms.bacs; break;
                        case "cash": lDe.Text = Razoom.Resources.forms.Forms.cash; break;
                        case "cheque": lDe.Text = Razoom.Resources.forms.Forms.cheque; break;
                        case "creditcard": lDe.Text = Razoom.Resources.forms.Forms.creditcard; break;
                        case "debitcard": lDe.Text = Razoom.Resources.forms.Forms.debitcard; break;
                        case "directdebit": lDe.Text = Razoom.Resources.forms.Forms.directdebit; break;
                        default: lDe.Text = Item.Description; break;
                    }
                    lA.Text = string.Format("{0} {1}", Item.Account.Code, Item.Account.Name);
                    lRef.Text = String.Format("{0}&nbsp;", Item.Payment.Reference);
                    lTotal.Text = aPurchase.PurchaseTransactionTypeID == PurchaseTransactionType.Purchase ? Razoom.Currency.Format(Item.Total * -1) : Razoom.Currency.Format(Item.Total);
                    if (Item.Payment.AddedUser != null)
                    {
                        lAddedBy.Text = Item.Payment.AddedUser.UserNameWithTitle;
                    }
                    lAddedDate.Text = String.Format("{0:d} {0:HH:mm}", AuthDetail.AuthLocation.ConvertTimeFromUtc(Item.Payment.AddedDate));

                    Razoom.Model.Interfaces.IIntegrationLocation<Allocation> IntegrationLocation = Item.Allocation.IntegrationLocationAllocations.FirstOrDefault();
                    if (IntegrationLocation != null)
                        if (!db.Entry<IntegrationLocationAllocation>(IntegrationLocation as IntegrationLocationAllocation).Reference(f => f.Integration).IsLoaded)
                        {
                            db.Entry<IntegrationLocationAllocation>(IntegrationLocation as IntegrationLocationAllocation).Reference(f => f.Integration).Load();
                        }
                    if (IntegrationLocation != null)
                    {
                        aAccountIntegrationPayment.InnerHtml = string.Format("<i class=\"logo logo-{0}-24\"></i>", IntegrationLocation.Integration.Name.ToLower());
                        aAccountIntegrationPayment.HRef = IntegrationLocation.Link;
                        aAccountIntegrationPayment.Attributes.RemoveClass("hide");
                        if (!String.IsNullOrEmpty(IntegrationLocation.ErrorID))
                        {
                            aAccountIntegrationPayment.InnerHtml += "<i class=\"logo-error-24\"></i>";
                        }
                    }
                }
            }
        }

        void rOffset_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.DataItem is Razoom.Model.Item)
            {
                Razoom.Model.Item Item = (Razoom.Model.Item)(e.Item.DataItem);
                if (Item.Allocation != null)
                {
                    Literal lDe = (Literal)e.Item.FindControl("lDe");
                    Literal lTotal = (Literal)e.Item.FindControl("lTotal");
                    Literal lAddedBy = (Literal)e.Item.FindControl("lAddedBy");
                    Literal lAddedDate = (Literal)e.Item.FindControl("lAddedDate");
                    System.Web.UI.HtmlControls.HtmlAnchor aAccountIntegrationOffset = (System.Web.UI.HtmlControls.HtmlAnchor)e.Item.FindControl("aAccountIntegrationOffset");

                    lDe.Text = Item.Description.Replace(Item.Allocation.Number, String.Format("<a href=\"../Invoice/allocate.aspx?p={0}&a={1}\">{2}</a>", aPurchase.PurchaseID, Item.AllocationID, Item.Allocation.Number));
                    lTotal.Text = aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit ? Razoom.Currency.Format(Item.Total * -1) : Razoom.Currency.Format(Item.Total);
                    lAddedBy.Text = Item.Allocation.AddedUser.UserNameWithTitle;
                    lAddedDate.Text = String.Format("{0}", AuthDetail.AuthLocation.ConvertTimeFromUtc(Item.Allocation.AddedDate));

                    Razoom.Model.Interfaces.IIntegrationLocation<Allocation> IntegrationLocation = Item.Allocation.IntegrationLocationAllocations.FirstOrDefault();

                    if (IntegrationLocation != null)
                        if (!db.Entry<IntegrationLocationAllocation>(IntegrationLocation as IntegrationLocationAllocation).Reference(f => f.Integration).IsLoaded)
                        {
                            db.Entry<IntegrationLocationAllocation>(IntegrationLocation as IntegrationLocationAllocation).Reference(f => f.Integration).Load();
                        }

                    if (IntegrationLocation != null)
                    {
                        aAccountIntegrationOffset.InnerHtml = string.Format("<i class=\"logo logo-{0}-24\"></i>", IntegrationLocation.Integration.Name.ToLower());

                        Boolean Two = false;
                        if (Item.Allocation.IntegrationLocationAllocations.Any())
                            Two = Item.Allocation.IntegrationLocationAllocations.First().Link.Split(';').Count() > 1;

                        if (Two)
                        {
                            aAccountIntegrationOffset.HRef = Item.Allocation.IntegrationLocationAllocations.First().OffsetDeepLink(Razoom.Model.ItemHeaderType.Purchase).Split(';').Skip(1).First();
                        }

                        else aAccountIntegrationOffset.HRef = Item.Allocation.IntegrationLocationAllocations.First().OffsetDeepLink(Razoom.Model.ItemHeaderType.PurchaseCredit);

                        aAccountIntegrationOffset.Attributes.RemoveClass("hide");
                        if (!String.IsNullOrEmpty(IntegrationLocation.ErrorID))
                        {
                            aAccountIntegrationOffset.InnerHtml += "<i class=\"logo-error-24\"></i>";
                        }
                    }
                }
            }
        }

        void bPayment_Click(object sender, EventArgs e)
        {
            try
            {
                this.keepDB = true;
                decimal value;
                if (Decimal.TryParse(tPaymentValue.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentCulture.NumberFormat, out value))
                {
                    ICommittedDocumentCreatePayment CommittedDocumentCreatePayment = new Razoom.Model.Extension.Decorator.ReSaveDocumentCreatePaymentDecorator(aPurchase);
                    Allocation payment = CommittedDocumentCreatePayment.createPayment(db, AuthDetail.User, AuthDetail.Location, DateTime.Parse(tPaymentDate.Text), dPaymentType.SelectedValue, dPaymentAccount.SelectedValue, value, tPaymentReference.Text);

                    db.Entry<Allocation>(payment).Collection<Item>(f => f.Items).Query()
                        .Include(f => f.Purchase.Contact.ContactContactType)
                        .Include(f => f.Purchase.Contact.ContactMethods)
                        .Include(f => f.Purchase.Contact.IntegrationLocationContacts)
                        .Include(f => f.Purchase.IntegrationLocationPurchases).Load();

                    if (AuthDetail.AuthLocation.IntegrationLocations.Where(f => f.Integration.IntegrationTypeID == Razoom.Model.IntegrationType.Account).Any())
                    {
                        try
                        {
                            base.AccountingProcessor.SavePayment(payment);
                        }
                        catch (Razoom.Model.Extension.Map.Accounting.Exception.AccountingPaymentException paymentException)
                        {
                            updateMessage(false, paymentException.ResourceErrorKey);
                        }
                    }
                    bindItems(true);
                    bindPayment();
                }
                else
                    updateMessage(false, "invalidvalue");
            }
            catch (Exception ex)
            {
                LogError(ex);
                updateMessage(false, "updatefailed");
            }
        }

        protected override void OnPreInit(EventArgs e)
        {
            base.OnPreInit(e);
            if (aPurchase != null)
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.AppendLine(String.Format("var Committed = {0};", aPurchase.PurchaseDocument != null ? "true" : "false"));
                this.ClientScript.RegisterClientScriptBlock(this.GetType(), "Committed", sb.ToString(), true);
            }
        }

        void bAction_Click(object sender, EventArgs e)
        {
            if (((LinkButton)sender).CommandArgument.ToUpper() == "Commit".ToUpper())
            {
                CommitResponse response = DecoratePurchaseCommit(db, aPurchase);
                if (response.Status != Razoom.Model.Contract.ResponseStatus.Success)
                {
                    updateMessage(false, response.Errors.First().ResourceKey);
                }
                else
                {
                    bindItems(true);
                    bind();
                    DisableInput();
                }
            }
        }

        void lbDeleteJob_Click(object sender, EventArgs e)
        {
            DateTime transactionDate = DateTime.Now;
            int userID = AuthDetail.User.UserID;
            try
            {
                if (aPurchase.Job != null) //EXISTING STOCK LINKED TO IT
                {
                    hfJobID.Value = null;
                    pJob.Visible = false;
                    lJobName.Text = "";
                    aPurchase.JobID = null;
                    aPurchase.UpdatedDate = transactionDate;
                    aPurchase.UpdatedUserID = userID;
                    SaveChanges();
                    bind();
                    updateMessage(true, "removed");
                }
                else //INCOMING STOCK FROM URL
                {
                    pJobSelect.Visible = false;
                    lSelected.Text = "";
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                updateMessage(true, "faileddelete");
            }
        }
        void lbDeleteStock_Click(object sender, EventArgs e)
        {
            DateTime transactionDate = DateTime.Now;
            int userID = AuthDetail.User.UserID;
            try
            {
                if (aPurchase.Stock != null) //EXSISTING STOCK LINKED TO IT
                {
                    List<Razoom.Model.Item> aItemPurchaseID = new List<Razoom.Model.Item>();
                    aItemPurchaseID = db.Items.Where(a => a.PurchaseID == aPurchase.PurchaseID).OrderBy(x => x.AddedDate).ToList();
                    foreach (var item in aItemPurchaseID)
                    {
                        if (item.StockID != null)
                        {
                            item.StockID = null;
                            item.UpdatedDate = transactionDate;
                            item.UpdatedUserID = userID;
                        }
                    }
                    if (spanUnPaid.Visible)
                    {
                        isWarningEditStock = true;
                    }
                    else
                    {
                        isWarningEditStock = false;
                    }
                    aPurchase.UpdatedDate = transactionDate;
                    aPurchase.UpdatedUserID = userID;
                    hfStockID.Value = null;
                    pStock.Visible = false;
                    lStockName.Text = "";
                    aPurchase.StockID = null;
                    SaveChanges();
                    bind();
                    updateMessage(true, "removed");
                }
                else //INCOMING STOCK FROM URL
                {
                    pStockSelect.Visible = false;
                    lSelectedStock.Text = "";
                }
            }
            catch (Exception ex)
            {
                LogError(ex);
                updateMessage(true, "faileddelete");
            }
        }

        void rs_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    LinkButton btDelete = (LinkButton)e.CommandSource;
                    aPurchase.removeItem(db, AuthDetail.User, AuthDetail.Location, Int32.Parse(btDelete.CommandArgument.ToString()));
                    bindItems(true);
                    updateMessage(true, "removed");
                }
                catch (Exception ex)
                {
                    LogError(ex);
                }
            }
        }

        void bindItems(Boolean forceRefresh = false)
        {
            if (aPurchase != null)
            {
                Boolean LazyLoading = db.Configuration.LazyLoadingEnabled;
                db.Configuration.LazyLoadingEnabled = false;

                if (!db.Entry<Purchase>(aPurchase).Collection<Item>(f => f.Items).IsLoaded || forceRefresh)
                {
                    aPurchase.loadItems(db);
                }

                if (aPurchase.Items.Any())
                {
                    rs.DataSource = aPurchase.Items.NormalItems().ToList();
                    rs.DataBind();

                    rPayment.DataSource = aPurchase.Items.PaymentItems().NonDefaultItems().ToList();
                    rPayment.DataBind();

                    Decimal totaloffset = aPurchase.Items.OffsetItems().Where(f => f.Allocation.CommitDate.HasValue).Sum(s => s.Net) * (int)aPurchase.EntryType;

                    lSubT.Text = Razoom.Currency.Format(aPurchase.Subtotal);
                    lTax.Text = Razoom.Currency.Format(aPurchase.tax);
                    lTot.Text = Razoom.Currency.Format(aPurchase.total);

                    lPayMade.Text = Razoom.Currency.Format(aPurchase.totalpayment);
                    lPaymentOwed.Text = aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit ? Razoom.Currency.Format(aPurchase.Owed) : Razoom.Currency.Format(aPurchase.Owed * -1);
                    tPaymentValue.Text = aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit ? Razoom.Currency.Format(aPurchase.Owed) : Razoom.Currency.Format(aPurchase.Owed * -1);
                    tPaymentDate.Text = String.Format("{0:d}", AuthDetail.AuthLocation.ConvertTimeFromUtc(System.DateTime.UtcNow));
                }
                else
                {
                    lSubT.Text = Razoom.Currency.Format(0);
                    lTax.Text = Razoom.Currency.Format(0);
                    lTot.Text = Razoom.Currency.Format(0);
                    lPaymentOwed.Text = Razoom.Currency.Format(0);
                    tPaymentValue.Text = Razoom.Currency.Format(0);

                    rs.DataSource = new List<Razoom.Model.Item>();
                    rs.DataBind();

                    rPayment.DataSource = new List<Razoom.Model.Allocation>();
                    rPayment.DataBind();
                }

                db.Configuration.LazyLoadingEnabled = LazyLoading;

                if (aPurchase.IntegrationLocationPurchases.Any(i => i.IntegrationID == Integration.Xero))
                {
                    pEditLineItemXeroConfirm.Visible = true;
                }
                else
                {
                    pEditLineItemXeroConfirm.Visible = false;
                }

                if (aPurchase.StockID != null)
                {
                    pEditLineItemWithStock.Visible = true;
                }
                else
                {
                    pEditLineItemWithStock.Visible = false;
                }

                if (!aPurchase.IntegrationLocationPurchases.Any(i => i.IntegrationID == Integration.Xero) && aPurchase.StockID == null)
                {
                    pEditLineItem.Visible = true;
                }
                else
                {
                    pEditLineItem.Visible = false;
                }
            }
        }

        protected void bindPayment()
        {
            spanUnPaid.Visible = (aPurchase.Owed != 0 && !aPurchase.Items.AllocationItems().Where(f => f.Allocation.CommitDate.HasValue).Any());
            spanPaid.Visible = (aPurchase.Owed == 0 && aPurchase.Items.AllocationItems().Any());
            spanPartPaid.Visible = (aPurchase.Owed != 0 && aPurchase.Items.AllocationItems().Any());
            panelPayment.Visible = true;
            if (spanUnPaid.Visible && ((AuthDetail.PermissionID.ToLower() == Razoom.Model.Permission.Super.ToLower()) || AuthDetail.PermissionID.ToLower() == Razoom.Model.Permission.Admin.ToLower()))
            {
                aRepairLineItem.Visible = true;
                liEdit.Visible = true;
                lbEdit.Text = String.Format("<i class ='icon icon-edit'></i> {0}", Razoom.Resources.forms.Forms.edit);
            }
            else
            {
                aRepairLineItem.Visible = false;
                liEdit.Visible = false;
            }
            dPaymentAccount.Items.Clear();
            List<Razoom.Model.Account> accounts = MyLocation.Accounts.Where(f => f.DeletedDate == null && f.ReceivePayment).ToList();
            foreach (Razoom.Model.Account f in accounts)
            {
                dPaymentAccount.Items.Add(new ListItem(f.Name + " (" + f.Code + ")", f.AccountID));
            }
            if (spanPartPaid.Visible || spanPaid.Visible)
            {
                liDeletelLineItem.Visible = false;
            }

            dPaymentType.Items.Clear();
            dPaymentType.Items.AddRange(db.PaymentTypes.ToList().Select(f => new ListItem(Razoom.Resources.forms.Forms.ResourceManager.GetString(f.Name.ToLower()), f.PaymentTypeID)).ToArray());

            Decimal Available = aPurchase.EntryType == E_Ledger_EntryType.Debit ? aPurchase.Contact.AvailableDebit(AuthDetail.LocationID, db) : aPurchase.Contact.AvailableCredit(AuthDetail.LocationID, db);
            Decimal Draft = aPurchase.EntryType == E_Ledger_EntryType.Debit ? aPurchase.Contact.DraftDebit(AuthDetail.LocationID, db) : aPurchase.Contact.DraftCredit(AuthDetail.LocationID, db);
            warning.Text = Draft <= 0 ? "" : String.Format("<span class='label warning invert'><i class='icon-warning-sign'></i>{0}: {1}</span>", Razoom.Resources.forms.Forms.draftinvoice, Razoom.Currency.Format(Draft));
            hOffset.Text = Razoom.Currency.Format(Available);
            if (Available > 0 && aPurchase.Owed != 0)
            {
                hOffset.NavigateUrl = String.Format("~/invoice/allocate.aspx?p={0}{1}", aPurchase.PurchaseID, GetFullID);

                if (AuthDetail.AuthLocation.ContainerID == Razoom.Model.Container.CastrolPoland)
                    bOffset.Text = String.Format(
                   "<a href='/Invoice/allocate.aspx?p={0}{1}' class='button primary small requiredNav'>{2}</a> ",
                   aPurchase.PurchaseID, GetFullID, Razoom.Resources.forms.Forms.offset.ToUpper());
                else
                    bOffset.Text = String.Format(
                   "<a href='/Invoice/allocate.aspx?p={0}{1}' class='button primary requiredNav'>{2}</a> ",
                   aPurchase.PurchaseID, GetFullID, Razoom.Resources.forms.Forms.offset.ToUpper());
            }
            else
            {
                offset.Visible = false;
                bOffset.Text = String.Format("");
            }

            rOffset.DataSource = aPurchase.Items.OffsetItems();
            rOffset.DataBind();

            if (aPurchase.IntegrationLocationPurchases.Any(i => i.IntegrationID == Integration.Xero))
            {
                pEditLineItemXeroConfirm.Visible = true;
            }
            else
            {
                pEditLineItemXeroConfirm.Visible = false;
            }

            if (aPurchase.StockID != null)
            {
                pEditLineItemWithStock.Visible = true;
            }
            else
            {
                pEditLineItemWithStock.Visible = false;
            }

            if (!aPurchase.IntegrationLocationPurchases.Any(i => i.IntegrationID == Integration.Xero) && aPurchase.StockID == null)
            {
                pEditLineItem.Visible = true;
            }
            else
            {
                pEditLineItem.Visible = false;
            }
        }

        protected void bindHeader()
        {
            if (aPurchase != null)
            {
                if (!db.Entry<Purchase>(aPurchase).Reference(f => f.Contact).IsLoaded)
                {
                    db.Entry<Purchase>(aPurchase).Reference(f => f.Contact).Query().Include(f => f.ContactMethods.Select(g => g.ContactMethodType)).Include(f => f.ContactContactType.ContactType).Load();
                }
            }

            if (aPurchase != null && aPurchase.Contact != null)
            {
                newPurchaseHref.Text = String.Format("<a href = 'edit.aspx?ptt={0}' class='button success requiredNav'><i class='icon-add'></i></a>", aPurchase.PurchaseTransactionTypeID);

                //set side menu
                carvue.controls.fastMenuPurchase cnFastMenu = (carvue.controls.fastMenuPurchase)this.Page.Master.FindControl("fastMenuPurchase");
                cnFastMenu.aPurchaseID = aPurchase.PurchaseID;
                cnFastMenu.Visible = true;

                if (AuthDetail.PermissionID != Razoom.Model.Permission.Super.ToLower())
                    liDelete.Visible = false;

                bAction.Text = aPurchase.PurchaseDocument == null ? String.Format("<i class=\"icon-tick\"></i> {0}", Razoom.Resources.forms.Forms.commit) : String.Format("<i class=\"icon-blocked\"></i> {0}", Razoom.Resources.forms.Forms.credit);
                bAction.CommandArgument = aPurchase.PurchaseDocument == null ? "Commit" : "Credit";
                bAction.Visible = (aPurchase.PurchaseDocument == null);

                Razoom.Model.Contact con = aPurchase.Contact;
                string cEdit = "";
                if (con != null)
                {
                    cEdit = String.Format("&nbsp;<a href='#' data-reveal-id='generic-modal' onclick='setGenericModal(\"Contact\",\"&contactid={0} \")' ><i class='icon-modal'></i></a>", con.ContactID);

                    lContact.Text = con.Name + cEdit;
                    tbAtten.Text = con.bAttention;
                    tbAdd1.Text = con.bAddress1;
                    tbAdd2.Text = con.bAddress2;
                    tbAdd3.Text = con.bAddress3;
                    tbAdd4.Text = con.bAddress4;
                    tbAdd5.Text = con.bPostcode;
                }
                tRef.Text = aPurchase.Reference;
                tbAtten.Text = aPurchase.bAttention;
                tbAdd1.Text = aPurchase.bAddress1;
                tbAdd2.Text = aPurchase.bAddress2;
                tbAdd3.Text = aPurchase.bAddress3;
                tbAdd4.Text = aPurchase.bAddress4;
                tbAdd5.Text = aPurchase.bPostcode;
                chkVDecl.Checked = aPurchase.Declaration;
                tSup.Enabled = false;

                tSup.Text = con.Name != null ? con.Name : "-";
                hfContactID.Value = aPurchase.ContactID.ToString();
                dUsers.SelectedValue = aPurchase.PurchaseUserID.ToString();
                tPDate.Text = String.Format("{0:d}", AuthDetail.AuthLocation.ConvertTimeFromUtc(aPurchase.PurchaseDate));
                tNumber.Text = aPurchase.Number;
                lPurchNo.Text = aPurchase.Number;
                hlDocument.NavigateUrl = String.Format("/Services/Operation.svc/Purchase/{0}/{1}", aPurchase.PurchaseID, aPurchase.Declaration ? "true" : "false");//String.Format("../services.aspx?link={0}", String.Format("/Services/Operation.svc/Purchase/{0}", aPurchase.PurchaseID));

                if (aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.Purchase)
                {
                    hlDocument.Text = aPurchase.PurchaseDocument == null ? String.Format("<i class=\"icon-printer\"></i>Print Purchase", Razoom.Resources.forms.Forms.view, Razoom.Resources.forms.Forms.draft) : String.Format("<i class=\"icon-printer\"></i>Print Purchase", Razoom.Resources.forms.Forms.view, Razoom.Resources.forms.Forms.purchaseorder);
                }
                else if (aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit)
                {
                    hlDocument.Text = aPurchase.PurchaseDocument == null ? String.Format("<i class=\"icon-printer\"></i>Print Purchase Credit", Razoom.Resources.forms.Forms.view, Razoom.Resources.forms.Forms.draft) : String.Format("<i class=\"icon-printer\"></i>Print Purchase Credit", Razoom.Resources.forms.Forms.view, Razoom.Resources.forms.Forms.purchaseorder);
                }



                hlDocument.Target = "_Blank";
                lbSavePurchase.Visible = true;
                if (aPurchase.PurchaseDocument != null)
                {
                    ldraft.Text = "";
                    lHeader.Text = String.Format("{0}", Razoom.Resources.forms.Forms.purchase);
                    bindPayment();
                    divNewItm.Visible = false;
                    rAccountIntegration.DataSource = aPurchase.IntegrationLocationPurchases;
                    rAccountIntegration.DataBind();
                }
                else
                {
                    ldraft.Text = String.Format("({0})", Razoom.Resources.forms.Forms.draft);
                    lHeader.Text = String.Format("{0}", Razoom.Resources.forms.Forms.draftpurchase);
                }
                //NOTES AND EVENT HISTORY
                rNotes.PurchaseID = aPurchase.PurchaseID;
                rNotes.bind();
                //email
                if (aPurchase.Committed)
                {
                    liEmail.Visible = true;
                    emailDeleteAnchor.Visible = true;

                    if (this.aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit)
                    {
                        tbSubject.Text = String.Format("{0} {1} - {2}", Razoom.Resources.forms.Forms.purchasecredit, aPurchase.Number, MyLocation.Name);
                        lAttch.Text = AuthDetail.AuthLocation.Container.ApplicationName + Razoom.Resources.forms.Forms.purchasecredit + "_" + aPurchase.Number + ".pdf";
                    }

                    else
                    {
                        tbSubject.Text = String.Format("{0} {1} - {2}", Razoom.Resources.forms.Forms.purchase, aPurchase.Number, MyLocation.Name);
                        lAttch.Text = AuthDetail.AuthLocation.Container.ApplicationName + Razoom.Resources.forms.Forms.purchase + "_" + aPurchase.Number + ".pdf";
                    }

                    if (aPurchase.Contact.ContactMethods.Any(a => a.ContactMethodTypeID == Razoom.Model.ContactMethodType.Email))
                    {
                        string email = aPurchase.Contact.ContactMethods.Where(a => a.ContactMethodTypeID == Razoom.Model.ContactMethodType.Email).Select(s => s.Name).FirstOrDefault();
                        tbemailtop.Text = String.Format("{0}", email);
                    }

                    lemailFrom.Text = "noreply@carvue.com";
                    lFileSize.Text = String.Format(" <i class='icon-file-pdf'></i>");
                }
                rQNotes.DataSource = MyLocation.QuickNotes.Where(f => f.QuickNoteTypeID == QuickNoteType.Email).OrderBy(g => g.OrderBy);
                rQNotes.DataBind();
                if (AuthDetail != null)
                {
                    dqnWrapper.Attributes["aULN"] = AuthDetail.User.Lastname;
                    dqnWrapper.Attributes["aUFN"] = AuthDetail.User.Firstname;
                }
                if (aPurchase != null)
                {
                    dqnWrapper.Attributes["aCLN"] = aPurchase.Contact.LastName;
                    dqnWrapper.Attributes["aCFN"] = aPurchase.Contact.FirstName;
                    dqnWrapper.Attributes["aDN"] = aPurchase.Contact.Name;
                    dqnWrapper.Attributes["aP"] = aPurchase.Items.VehicleItems().Any() ? aPurchase.Items.VehicleItems().Select(f => f.Vehicle).First().Reg : aPurchase.Items.Any(f => f.JobID != null && f.Job.VehicleID != null) ? aPurchase.Items.FirstOrDefault(f => f.JobID != null && f.Job.VehicleID != null).Job.Vehicle.Reg : "";
                }
                ctrEvent.PurchaseID = aPurchase.PurchaseID;
                ctrEvent.bind();
            }
            else
            {
                ldraft.Text = String.Format("{0}", Razoom.Resources.forms.Forms.newpurchase);
                lHeader.Text = String.Format("{0}", Razoom.Resources.forms.Forms.newpurchase);
                bAction.Visible = false;
                aNoteTab.Visible = false;
                tPDate.Text = String.Format("{0:d}", AuthDetail.AuthLocation.ConvertTimeFromUtc(DateTime.UtcNow));
                lbSavePurchase.Visible = true;
                optionList.Visible = false;
                hlDocument.Visible = false;
                if (aContactID != null)
                {
                    lContact.Text = aContact.Name;
                    tSup.Text = aContact.ContactName;
                    tbAtten.Text = aContact.bAttention;
                    tbAdd1.Text = aContact.bAddress1;
                    tbAdd2.Text = aContact.bAddress2;
                    tbAdd3.Text = aContact.bAddress3;
                    tbAdd4.Text = aContact.bAddress4;
                    tbAdd5.Text = aContact.bPostcode;

                    hfContactID.Value = aContactID;
                }
            }
            // JOB LINKED TO THIS PURCHASE
            if (aJob != null || aPurchase != null)
            {
                if (aJob != null) //INCOMING JOB FROM URL
                {
                    pJobSelect.Visible = true;
                    lSelected.Text = String.Format("<a href='../workshop/edit.aspx?j={0}'>{1} - {2} - {3} - {4} {5}</a>",
                        aJob.JobID, aJob.Number, aJob.Contact.ContactName, aJob.Vehicle.Reg, aJob.Vehicle.MakeDescription, aJob.Vehicle.ModelDescription);
                    lCross.Text = "<a href='#!' class='pull-right button plain small'><i class='icon-cross'></i></a>";
                }
                else if (aPurchase.Job != null) //EXISTING JOB LINKED TO IT
                {
                    db.Entry<Job>(aPurchase.Job).Reference(c => c.Vehicle).Load();
                    db.Entry<Job>(aPurchase.Job).Reference(c => c.Contact).Load();
                    pJob.Visible = true;
                    lJobName.Text = String.Format("<a href='../workshop/edit.aspx?j={0}'>{1} - {2} - {3} - {4} {5}</a>",
                        aPurchase.Job.JobID, aPurchase.Job.Number, aPurchase.Job.Contact.ContactName, aPurchase.Job.Vehicle.Reg, aPurchase.Job.Vehicle.MakeDescription, aPurchase.Job.Vehicle.ModelDescription);
                }
                else
                    pJobSelect.Visible = true;
            }
            else
                pJobSelect.Visible = true;
            // STOCK LINKED TO THIS PURCHASE
            if (aStock != null || aPurchase != null)
            {
                if (aStock != null) //INCOMING STOCK FROM URL
                {
                    pStockSelect.Visible = true;
                    hfStockID.Value = aStock.StockID;
                    lSelectedStock.Text = String.Format("<a href='../sales/edit.aspx?s={0}'>{1} - {2} - {3} {4}</a>",
                        aStock.StockID, aStock.Number, aStock.Vehicle.Reg, aStock.Vehicle.MakeDescription, aStock.Vehicle.ModelDescription);
                    lCrossStck.Text = "<a href='#!' class='pull-right button plain small'><i class='icon-cross'></i></a>";
                }
                else if (aPurchase.Stock != null) //EXISTING STOCK LINKED TO IT
                {
                    db.Entry<Stock>(aPurchase.Stock).Reference(c => c.Vehicle).Load();
                    hfStockID.Value = aPurchase.StockID;
                    pStock.Visible = true;
                    lStockName.Text = String.Format("<a href='../sales/edit.aspx?s={0}'>{1} - {2} - {3} {4}</a>",
                        aPurchase.Stock.StockID, aPurchase.Stock.Number, aPurchase.Stock.Vehicle.Reg, aPurchase.Stock.Vehicle.MakeDescription, aPurchase.Stock.Vehicle.ModelDescription);
                    dVDecl.Visible = true;
                }
                else
                    pStockSelect.Visible = true;
            }
            else
                pStockSelect.Visible = true;

            //LABELLING CONTROL FOR PURCHASE OR PURCHASE CREDIT
            lsupplier.Text = Razoom.Resources.forms.Forms.supplier;
            lpurchaseno.Text = Razoom.Resources.forms.Forms.purchaseno;
            lpurchaseref.Text = Razoom.Resources.forms.Forms.purchaseref;
            lpurchasedate.Text = Razoom.Resources.forms.Forms.purchasedate;
            lpurchaseby.Text = Razoom.Resources.forms.Forms.purchaseby;
            newPurchaseHref.Text = String.Format("<a href = 'edit.aspx?ptt={0}' class='button success requiredNav'><i class='icon-add'></i></a>", Razoom.Model.PurchaseTransactionType.Purchase);


            if (PurchaseTransactionType != null)
            {
                if (PurchaseTransactionType.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit)
                {
                    if (aPurchase != null && aPurchase.Committed)
                    {
                        lHeader.Text = String.Format("{0}", Razoom.Resources.forms.Forms.purchasecredit);
                    }

                    else
                    {
                        lHeader.Text = String.Format("{0}", Razoom.Resources.forms.Forms.draftpurchasecredit);

                        if (aPurchase != null && aPurchase.PurchaseDocument == null)
                        {
                            ldraft.Text = String.Format("({0})", Razoom.Resources.forms.Forms.draft);
                        }

                        else ldraft.Text = String.Format("{0}", Razoom.Resources.forms.Forms.purchasecredit);
                    }

                    lsupplier.Text = String.Format("{0}", Razoom.Resources.forms.Forms.creditfrom);
                    lpurchaseno.Text = String.Format("{0}", Razoom.Resources.forms.Forms.purchasecreditnumber);
                    lpurchaseref.Text = String.Format("{0}", Razoom.Resources.forms.Forms.purchasecreditreference);
                    lpurchasedate.Text = String.Format("{0}", Razoom.Resources.forms.Forms.purchasecreditdate);
                    lpurchaseby.Text = String.Format("{0}", Razoom.Resources.forms.Forms.purchasecreditby);
                    newPurchaseHref.Text = String.Format("<a href = 'edit.aspx?ptt={0}' class='button success requiredNav'><i class='icon-add'></i></a>", Razoom.Model.PurchaseTransactionType.PurchaseCredit);
                    emailDeleteAnchor.Visible = true;
                }
            }
        }

        protected void returnAddress()
        {
            lGoBackDesc.Text = String.Format("<label class'inline'>{0}</label>", Razoom.Resources.forms.Forms.returnto);

            string tmpURL = backToURL(GoBackJobID, GoBackStockID, GoBackVehicleID);
            if (tmpURL != "")
            {
                lGoBack.Text = tmpURL;
            }
            else
            {
                lGoBack.Text = "";
                lGoBackDesc.Text = "";
            }
        }

        protected override void bind()
        {
            db.Entry<Location>(MyLocation).Collection(c => c.Accounts).Load();
            db.Entry<Location>(MyLocation).Collection(c => c.TaxGroups).Load();
            db.Entry<Location>(MyLocation).Collection(c => c.UserLocations).Query().Include(c => c.User).Include(c => c.UserLocationPositions).Load();
            db.Entry<Location>(MyLocation).Collection(c => c.QuickNotes).Query().Include(c => c.QuickNoteType).Load();

            lbEditWarning.Visible = false;
            if (isWarningEdit)
            {
                if (aPurchase.IntegrationLocationPurchases.Any(i => i.IntegrationID == Integration.Xero))
                {
                    lbEditWarning.Visible = true;
                    lbEditWarning.Text = String.Format("<i class='icon-warning-sign'></i> {0}", Razoom.Resources.forms.Forms.editinvoiceheaderwarningmessagexero);
                }
                else
                {
                    lbEditWarning.Visible = false;
                }
            }
            if (isWarningEditStock)
            {
                if (aPurchase.IntegrationLocationPurchases.Any(i => i.IntegrationID == Integration.Xero))
                {
                    lbEditWarning.Visible = true;
                    lbEditWarning.Text = String.Format("<i class='icon-warning-sign'></i> {0} </br> <i class='icon-warning-sign'></i> {1}", Razoom.Resources.forms.Forms.editinvoiceheaderwarningmessagexero, Razoom.Resources.forms.Forms.editPurchaseheaderwarningmessage);
                }
                else
                {
                    lbEditWarning.Visible = true;
                    lbEditWarning.Text = String.Format("<i class='icon-warning-sign'></i> {0}", Razoom.Resources.forms.Forms.editPurchaseheaderwarningmessage);
                }
            }
            returnAddress();

            if (tTax.Text != "")
            {

            }

            search.type = "purchases";
            search.bind();

            if (aTaxGroup != null)
            {
                BindTaxDropDown(dTax, AccountType.E_AccountType.EXPENSE);
                BindTaxDropDown(dTaxEdit, AccountType.E_AccountType.EXPENSE);
                dTax.SelectedValue = aTaxGroup.TaxGroupID;
                dTaxEdit.SelectedValue = aTaxGroup.TaxGroupID;
            }
            //if coming from a job (additional item)
            else if (aStock != null && aTaxGroup == null)
            {
                //set tax rate to be additional item tax
                BindTaxDropDown(dTax, AccountType.E_AccountType.REVENUE);
                validateTaxSelectedValue(db, dTax, LocationDefaultTaxGroup.TaxForStockAdditionalItems);

                BindTaxDropDown(dTaxEdit, AccountType.E_AccountType.REVENUE);
                validateTaxSelectedValue(db, dTaxEdit, LocationDefaultTaxGroup.TaxForStockAdditionalItems);
            }
            //else set tax rate to be purchase item tax
            else if (db.LocationDefaultTaxGroups.Any(f => f.LocationID == LocationID && f.DefaultID == LocationDefaultTaxGroup.TaxForPurchaseItems))
            {
                BindTaxDropDown(dTax, AccountType.E_AccountType.EXPENSE);
                validateTaxSelectedValue(db, dTax, LocationDefaultTaxGroup.TaxForPurchaseItems);

                BindTaxDropDown(dTaxEdit, AccountType.E_AccountType.EXPENSE);
                validateTaxSelectedValue(db, dTaxEdit, LocationDefaultTaxGroup.TaxForPurchaseItems);
            }
            else
                BindTaxDropDown(dTax, AccountType.E_AccountType.EXPENSE);
            BindTaxDropDown(dTaxEdit, AccountType.E_AccountType.EXPENSE);

            if (AuthDetail.AuthLocation.Container.ContainerCountry.UnitOfMeasure)
                divAccountAdd.Attributes["class"] = "medium-1 columns";
            else
                divAccountAdd.Attributes["class"] = "medium-2 columns";

            svehicle.Visible = false;
            if (aStock != null)
            {
                tQty.Text = "1";
                tRef.Text = Razoom.Resources.forms.Forms.from + " " + Razoom.Resources.forms.Forms.stock + ":" + aStock.Number;
            }

            BindUnitOfMeasure(dUnitOfMeasure, null);
            if (aAccount != null)
            {
                BindAccountDropDown(dAccount, MyLocation.UserAccounts.Where(f => f.AccountTypeID == aAccount.AccountTypeID).Active().ToList());

                BindAccountDropDownEdit(dAccEdit, MyLocation.UserAccounts.Where(f => f.AccountTypeID == aAccount.AccountTypeID).Active().ToList());

                //BindAccountDropDown(dAccEdit, MyLocation.UserAccounts.Where(f => f.AccountTypeID == aAccount.AccountTypeID).Active().ToList());

                if (aStock != null)
                {
                    if (aAccount.AccountTypeID != AccountType.EXPENSE && aContactID == aStock.FinanceContactID)
                        tvalue.Text = Razoom.Currency.Format(aStock.OutstandingFinance);
                    else
                        tvalue.Text = aAccount.AccountTypeID != Razoom.Model.AccountType.EXPENSE ? Razoom.Currency.Format(aStock.Cost - aStock.OutstandingFinance) : Razoom.Currency.Format(0);

                    tDescription.Text = aAccount.AccountTypeID != Razoom.Model.AccountType.EXPENSE ? aStock.Vehicle.StockvehicleDesc : "";
                    lDesc.Text = aAccount.AccountTypeID != Razoom.Model.AccountType.EXPENSE ? "<a href=../vehicle/edit.aspx?s=" + aStock.VehicleID + "><i class='icon-cv-vehicle'></i> " + Razoom.Resources.forms.Forms.vehicle + ": " + aStock.Vehicle.Reg + "</a>" : "";
                    hfV.Value = aAccount.AccountTypeID != Razoom.Model.AccountType.EXPENSE ? aStock.VehicleID : "";
                    svehicle.Visible = aAccount.AccountTypeID != Razoom.Model.AccountType.EXPENSE;
                    dVDecl.Visible = true;
                }
            }
            else
            {
                BindAccountDropDown(dAccount, MyLocation.UserAccounts.Where(f => f.Expense || f.Asset).Active().ToList());
                BindAccountDropDownEdit(dAccEdit, MyLocation.UserAccounts.Where(f => f.Expense || f.Asset).Active().ToList());

                validateAccountSelectedValue(db, dAccount, LocationDefaultTaxGroup.AccountForPurchaseItems);
                validateAccountEditSelectedValue(db, dAccEdit, LocationDefaultTaxGroup.AccountForPurchaseItems);

                BindAccountDropDownEdit(dAccEdit, MyLocation.UserAccounts.Where(f => f.Expense || f.Asset).Active().ToList());
                BindAccountDropDown(dAccount, MyLocation.UserAccounts.Where(f => f.Expense || f.Asset).Active().ToList());
            }

            ////if coming from a job (additional item)
            //else if (aStock != null && aAccount == null)
            //{
            //    //set account to be additional item account
            //    if (db.LocationDefaultAccounts.Any(f => f.LocationID == LocationID && f.DefaultID == LocationDefaultTaxGroup.SalesAccountForStockAdditionalItems))
            //    {
            //        BindAccountDropDown(dAccount, MyLocation.UserAccounts.Where(f => f.AccountTypeID == Razoom.Model.AccountType.REVENUE && f.Active).ToList());
            //        validateAccountSelectedValue(db, dAccount, LocationDefaultTaxGroup.SalesAccountForStockAdditionalItems);
            //    }
            //}
            ////else set account to be purchase item account
            //else if (db.LocationDefaultAccounts.Any(f => f.LocationID == LocationID && f.DefaultID == LocationDefaultTaxGroup.AccountForPurchaseItems))
            //{
            //    validateAccountSelectedValue(db, dAccount, LocationDefaultTaxGroup.AccountForPurchaseItems);            
            //}


            List<System.Web.UI.WebControls.ListItem> userItems = new List<System.Web.UI.WebControls.ListItem>();
            foreach (Razoom.Model.User aU in MyLocation.UserLocations.Select(a => a.User).OrderBy(b => b.UserName))
            {
                string aUserName = String.Format("{0} {1}", aU.Firstname, aU.Lastname);
                userItems.Add(new System.Web.UI.WebControls.ListItem(String.Format("{0} {1}", aU.Firstname, aU.Lastname), aU.UserID.ToString()));
            }
            dUsers.Items.AddRange(userItems.ToArray());
            dUsers.DataBind();

            if (dUsers.Items.FindByValue(AuthDetail.User.UserID.ToString()) != null)
                dUsers.SelectedValue = AuthDetail.User.UserID.ToString();

            spanPaid.Visible = false;
            spanUnPaid.Visible = false;
            spanPartPaid.Visible = false;
            bindItems();
            bindHeader();
            if (Request.QueryString["mp"] != null || MediaPurchaseAdded)
                updateMessage(true, "academyreward");

            if (aPurchase != null)
            {
                lPrint.Text = String.Format("<a id='cp_lPrint' class='button secondary requiredNav pull-right' href='/Services/Operation.svc/Purchase/{0}/{1}' target='_blank'>{2}</a>", aPurchase.PurchaseID, aPurchase.Declaration ? "true" : "false", Razoom.Resources.forms.Forms.print);
                lbReGen.Text = String.Format("<i class='icon-drawer'></i> {0}", Razoom.Resources.forms.Forms.regeneratedoc);
            }

            //db.Configuration.LazyLoadingEnabled = true;
            if (((AuthDetail.PermissionID.ToLower() != Razoom.Model.Permission.Super.ToLower()) && AuthDetail.PermissionID.ToLower() != Razoom.Model.Permission.Admin.ToLower()))
            {
                liDeletelLineItem.Visible = false;
            }
            if (aPurchase != null)
            {
                if (aPurchase.IntegrationLocationPurchases.Any(i => i.IntegrationID == Integration.Xero))
                {
                    pDeleteLineItemXeroConfirm.Visible = true;
                    pDeleteConfirmLineItem.Visible = false;
                }
                if (aPurchase.StockID != null)
                {
                    pDeleteLineItemStockConfirm.Visible = true;
                    pDeleteConfirmLineItem.Visible = false;
                }               
            }
        }

        void rs_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.DataItem is Razoom.Model.Item)
            {
                Razoom.Model.Item a = (Razoom.Model.Item)(e.Item.DataItem);

                Literal lA = (Literal)e.Item.FindControl("lA");
                Literal lC = (Literal)e.Item.FindControl("lC");
                Literal lTa = (Literal)e.Item.FindControl("lTa");
                Literal lTo = (Literal)e.Item.FindControl("lTo");
                Literal lQ = (Literal)e.Item.FindControl("lQ");
                Literal lUnitOfMeasure = (Literal)e.Item.FindControl("lUnitOfMeasure");
                Literal lDe = (Literal)e.Item.FindControl("lDe");
                Literal lTr = (Literal)e.Item.FindControl("lTr");
                Repeater rRelatedNav = (Repeater)e.Item.FindControl("rRelatedNav");
                DropDownList dAccount = (DropDownList)e.Item.FindControl("dAccount");
                DropDownList dUnitOfMeasure = (DropDownList)e.Item.FindControl("dUnitOfMeasure");
                System.Web.UI.HtmlControls.HtmlAnchor aEditItm = (System.Web.UI.HtmlControls.HtmlAnchor)e.Item.FindControl("aEditItm");
                HtmlGenericControl divAccountItems = e.Item.FindControl("divAccountItems") as HtmlGenericControl;

                lA.Text = string.Format("{0} {1}", a.Account.Code, a.Account.Name);
                if (lC != null) lC.Text = aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.Purchase ? Razoom.Currency.Format(a.Value) : Razoom.Currency.Format(a.Value * -1);

                lTo.Text = aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.Purchase ? Razoom.Currency.Format(a.Total) : Razoom.Currency.Format(a.Total * -1);
                if (a.VehicleID != null)
                    lDe.Text = a.Description + "<br/><span class='label round secondary'><a href=../vehicle/edit.aspx?v=" + a.VehicleID + "><i class='icon-cv-vehicle'></i> " + Razoom.Resources.forms.Forms.vehicle + ": " + a.Vehicle.Reg + "</a></span>";
                else
                    lDe.Text = a.Description;

                lQ.Text = String.Format("{0:0.00}", a.Quantity);
                lUnitOfMeasure.Text = a.UnitOfMeasure.TranslatedAbbreviation;
                if (a.TaxGroupID != null)
                {
                    lTr.Text = String.Format("{0} ({1})", a.TaxGroup.Name, a.TaxGroup.Rate);
                    lTa.Text = aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.Purchase ? Razoom.Currency.Format(a.Tax) : Razoom.Currency.Format(a.Tax * -1);
                }

                if (AuthDetail.AuthLocation.Container.ContainerCountry.UnitOfMeasure)
                    divAccountItems.Attributes["class"] = "medium-1 columns small-12";
                else
                    divAccountItems.Attributes["class"] = "medium-2 columns small-12";

                List<Razoom.Model.E_Navigation> NavList = new List<Razoom.Model.E_Navigation> { Razoom.Model.E_Navigation.Job, Razoom.Model.E_Navigation.Stock, Razoom.Model.E_Navigation.Purchase };

                aEditItm.Attributes.Add("serviceEdit", Convert.ToString(a.Description));
                aEditItm.Attributes.Add("accEdit", Convert.ToString(a.Account));
                aEditItm.Attributes.Add("qtyEdit", Convert.ToString(a.Quantity));
                aEditItm.Attributes.Add("valEdit", lC.Text);
                aEditItm.Attributes.Add("discEdit", Convert.ToString(a.DiscountPercentage));
                aEditItm.Attributes.Add("taxEdit", Convert.ToString(a.TaxGroup.Name));
                aEditItm.Attributes.Add("taxTotalEdit", lTa.Text);
                aEditItm.Attributes.Add("totalEdit", lTo.Text);
                rRelatedNav.ItemDataBound += rRelatedNav_ItemDataBound;
                rRelatedNav.DataSource = a.Navigation.Where(f => NavList.Any(f2 => f2 == f.Navigation));
                rRelatedNav.DataBind();

                aEditItm.Attributes.Add("item-id", a.ItemID.ToString());
                aEditItm.Attributes.Add("account-id", a.AccountID);
                if (a.Stock != null)
                {
                    aEditItm.Attributes.Add("stock-id", a.Stock.StockID);
                    aEditItm.Attributes.Add("stock-no", a.Stock.Number);
                    aEditItm.Attributes.Add("vehicle-reg", a.Stock.Vehicle.Reg);
                    aEditItm.Attributes.Add("vehicle-id", a.Stock.VehicleID);
                    if (a.VehicleID != null)
                        aEditItm.Attributes.Add("vehicle-checked", "true");
                }
                if (a.Job != null)
                {
                    aEditItm.Attributes.Add("job-id", a.Job.JobID);
                    aEditItm.Attributes.Add("job-no", a.Job.Number);
                }
            }
        }

        void rRelatedNav_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.DataItem is Razoom.Model.ItemNavigation)
            {
                Razoom.Model.ItemNavigation ItemNavigation = (Razoom.Model.ItemNavigation)e.Item.DataItem;
                HyperLink hlRelatedNav = (HyperLink)e.Item.FindControl("hlRelatedNav");
                switch (ItemNavigation.Navigation)
                {
                    case Razoom.Model.E_Navigation.Job:
                        hlRelatedNav.NavigateUrl = String.Format("~/workshop/edit.aspx?j={0}", ItemNavigation.ID);
                        Razoom.Model.Job Job = db.Jobs.Find(ItemNavigation.ID);
                        hlRelatedNav.Text = Job.Number;
                        break;
                    case Razoom.Model.E_Navigation.Stock:
                        hlRelatedNav.NavigateUrl = String.Format("~/sales/edit.aspx?s={0}", ItemNavigation.ID);
                        Razoom.Model.Stock Stock = db.Stocks.Find(ItemNavigation.ID);
                        hlRelatedNav.Text = Stock.Number;
                        break;
                    case Razoom.Model.E_Navigation.InvoiceTransaction:
                        hlRelatedNav.NavigateUrl = String.Format("~/invoice/createinvoice.aspx?it={0}", ItemNavigation.ID);
                        Razoom.Model.InvoiceTransaction InvoiceTransaction = db.InvoiceTransactions.Find(ItemNavigation.ID);
                        hlRelatedNav.Text = InvoiceTransaction.Number;
                        break;
                }
            }
        }
        void lbEdit_Click(object sender, EventArgs e)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.AppendLine(String.Format("Committed = {0};", "false"));
            this.ClientScript.RegisterClientScriptBlock(this.GetType(), "ToEnableCommitted", sb.ToString(), true);
            lbEditWarning.Visible = false;
            isWarningEdit = false;
            isWarningEditStock = false;
            tPDate.Enabled = false;
            bind();
            tSup.Enabled = true;
        }
        private void CreatePurchaseTransactionObject()
        {
            aPurchase.bAttention = tbAtten.Text;
            aPurchase.bAddress1 = tbAdd1.Text;
            aPurchase.bAddress2 = tbAdd2.Text;
            aPurchase.bAddress3 = tbAdd3.Text;
            aPurchase.bAddress4 = tbAdd4.Text;
            aPurchase.bPostcode = tbAdd5.Text;

        }

        private void lbSavePurchase_Click(object sender, EventArgs e)
        {
            DateTime transactionDate = DateTime.Now;
            int userID = AuthDetail.User.UserID;
            string oldStockId = null;
            if (aPurchase != null)
            {
                oldStockId = aPurchase.StockID;
                aPurchase.PurchaseUserID = Convert.ToInt32(dUsers.SelectedValue);
                aPurchase.PurchaseDate = Convert.ToDateTime(tPDate.Text);
                aPurchase.Reference = tRef.Text;
                aPurchase.Declaration = chkVDecl.Checked;

                if (aJob != null)
                    aPurchase.JobID = aJob.JobID;
                else if (hfJobID.Value.Length > 0)
                    aPurchase.JobID = hfJobID.Value;
                else if (ViewState["JobID"] != null)
                    aPurchase.JobID = ViewState["JobID"].ToString();
                if (aPurchase.JobID == null)
                {
                    aPurchase.JobID = null;
                }


                if (aStock != null)
                    aPurchase.StockID = aStock.StockID;
                else if (hfStockID.Value.Length > 0)
                    aPurchase.StockID = hfStockID.Value;
                else if (ViewState["StockID"] != null)
                    aPurchase.StockID = ViewState["StockID"].ToString();
                CreatePurchaseTransactionObject();
                aPurchase.UpdatedDate = transactionDate;
                aPurchase.UpdatedUserID = userID;
                aPurchase.ContactID = hfContactID.Value;
                List<Razoom.Model.Item> aItemPurchaseID = new List<Razoom.Model.Item>();
                aItemPurchaseID = db.Items.Where(a => a.PurchaseID == aPurchase.PurchaseID).OrderBy(x => x.AddedDate).ToList();                
                SaveChanges();
                foreach (var item in aItemPurchaseID)
                {
                    if (item.StockID == null || item.StockID != aPurchase.StockID)
                    {
                        item.StockID = aPurchase.StockID;
                        item.UpdatedDate = transactionDate;
                        item.UpdatedUserID = userID;
                    }
                }
                SaveChanges();
                bind();
                updateMessage(true, "updated");
            }
            else
            {
                try
                {
                    if (hfContactID.Value == "")
                        throw new Exception("contact");

                    if (dUsers.SelectedValue.Length < 1)
                        throw new Razoom.Logic.LogicException(Razoom.Resources.errorMessages.errorMessages.selectpurchaseuser, "selectpurchaseuser");

                    String JobID = null;
                    if (aJob != null)
                        JobID = aJob.JobID;
                    else if (hfJobID.Value.Length > 0)
                        JobID = hfJobID.Value;

                    String StockID = null;
                    if (aStock != null)
                        StockID = aStock.StockID;
                    else if (hfStockID.Value.Length > 0)
                        StockID = hfStockID.Value;

                    //create new instance
                    aPurchase = MyLocation.createPurchase(db, AuthDetail.User, PurchaseTransactionType.PurchaseTransactionTypeID, hfContactID.Value, Convert.ToInt32(dUsers.SelectedValue), Convert.ToDateTime(tPDate.Text), tRef.Text, AuthDetail, StockID, JobID, StockID != null ? chkVDecl.Checked : false);
                    CreatePurchaseTransactionObject();
                    aPurchase.PurchaseUserID = Convert.ToInt32(dUsers.SelectedValue);
                    aPurchase.UpdatedDate = transactionDate;
                    aPurchase.UpdatedUserID = userID;
                    SaveChanges();
                    bind();

                }
                catch (Razoom.Logic.LogicException ex)
                {
                    if (ex.ResourceErrorKey != null)
                        updateMessage(false, ex.ResourceErrorKey);
                    else
                        updateMessage(false, "failedcreate");
                }
                catch (Exception ex)
                {
                    if (ex.Message == "contact")
                        updateMessage(false, "nocontact");
                    else
                        updateMessage(false, "failedcreate");
                }
            }
            if (spanUnPaid.Visible && aPurchase.StockID != null && aPurchase.StockID !=oldStockId)
            {
                isWarningEditStock = true;
            }
            else
            if (spanUnPaid.Visible )
            {
                isWarningEdit = true;
            }
            else
            {
                isWarningEdit = false;
                isWarningEditStock = false;
            }          
            bind();

            if (aPurchase != null && Request.QueryString["ptt"] != null)
            {
                if (MediaPurchaseAdded)
                {
                    Response.Redirect(String.Format("edit.aspx?p={0}{1}&mp=1", aPurchase.PurchaseID, GetFullID), true);
                }
                else
                {
                    Response.Redirect(String.Format("edit.aspx?p={0}{1}", aPurchase.PurchaseID, GetFullID), true);
                }
            }
        }

        void bAdd_Click(object sender, EventArgs e)
        {
            bool reload = false;
            try
            {
                Razoom.Model.Item aItem = new Item();
                Guid aAccountID = new Guid(dAccount.SelectedValue);

                decimal dValue = Decimal.TryParse(tvalue.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentCulture.NumberFormat, out dValue) ? dValue : 0;
                decimal qty = Decimal.TryParse(tQty.Text, System.Globalization.NumberStyles.Number, System.Threading.Thread.CurrentThread.CurrentCulture.NumberFormat, out qty) ? qty : 0;

                String JobID = null;
                if (aJob != null)
                    JobID = aJob.JobID;
                else if (hfJobID.Value.Length > 0)
                    JobID = hfJobID.Value;
                else if (ViewState["JobID"] != null)
                    JobID = ViewState["JobID"].ToString();

                String StockID = null;
                if (aStock != null)
                    StockID = aStock.StockID;
                else if (hfStockID.Value.Length > 0)
                    StockID = hfStockID.Value;
                else if (ViewState["StockID"] != null)
                    StockID = ViewState["StockID"].ToString();

                //create purchase header
                if (aPurchase == null)
                {
                    if (hfContactID.Value == "")
                        throw new Exception("contact");

                    if (dUsers.SelectedValue.Length < 1)
                        throw new Exception("purchaseby");
                    //create new instance               
                    aPurchase = MyLocation.createPurchase(db, AuthDetail.User, PurchaseTransactionType.PurchaseTransactionTypeID, hfContactID.Value, Convert.ToInt32(dUsers.SelectedValue), Convert.ToDateTime(tPDate.Text), tRef.Text, AuthDetail, StockID, JobID);
                    reload = true;
                }
                else
                {
                    aPurchase.ContactID = hfContactID.Value;
                    aPurchase.PurchaseUserID = Convert.ToInt32(dUsers.SelectedValue);
                    aPurchase.PurchaseDate = Convert.ToDateTime(tPDate.Text);
                    if (JobID != null)
                        aPurchase.JobID = JobID;

                    aPurchase.StockID = StockID;
                }

                Razoom.Model.E_Ledger_EntryType EntryType = aPurchase.EntryType;
                if (dValue < 0) EntryType = EntryType = (E_Ledger_EntryType)(((int)aPurchase.EntryType) * -1);
                if (hfPackageID.Value.Length > 0)
                {
                    aPurchase.addPackage(db, AuthDetail.User, AuthDetail.Location, hfPackageID.Value, null, 0);
                }
                else if (hfProductID.Value.Length > 0)
                {
                    aItem = aPurchase.addProduct(db, AuthDetail.User, AuthDetail.Location, hfProductID.Value, null, dAccount.SelectedValue, dTax.SelectedValue, qty, dValue, 0, EntryType, (UnitOfMeasure.E_UnitOfMeasure)Convert.ToInt32(dUnitOfMeasure.SelectedValue));
                }
                else
                {
                    if (aStock != null && hfV.Value == aStock.VehicleID && aAccount != null)
                        aItem = aPurchase.createItem(db, AuthDetail.User, AuthDetail.Location, aPurchase.ContactID, aAccountID.ToString(), dTax.SelectedValue, tDescription.Text, qty, dValue, 0, null, null, null, aPurchase.PurchaseID, null, null, aStock.VehicleID, null, null, null, EntryType, (UnitOfMeasure.E_UnitOfMeasure)Convert.ToInt32(dUnitOfMeasure.SelectedValue));
                    else
                        aItem = aPurchase.createItem(db, AuthDetail.User, AuthDetail.Location, aPurchase.ContactID, aAccountID.ToString(), dTax.SelectedValue, tDescription.Text, qty, dValue, 0, null, null, null, aPurchase.PurchaseID, null, null, null, null, null, null, EntryType, (UnitOfMeasure.E_UnitOfMeasure)Convert.ToInt32(dUnitOfMeasure.SelectedValue));
                }
                CreatePurchaseTransactionObject();
                SaveChanges();
                hfProductID.Value = String.Empty;
                hfPackageID.Value = "";
                tItem.Text = "";
                tDescription.Text = "";
                tNumber.Text = "";
                tvalue.Text = "";
                tTax.Text = "";
                tQty.Text = "";
            }
            catch (Exception ex)
            {
                LogError(ex);
                if (ex.Message == "contact")
                    updateMessage(false, "addsupplier");
                else if (ex.Message == "purchaseby")
                    updateMessage(false, "failedvaliduser");
                else
                    updateMessage(false, "failedcreate");
                bindItems(true);
                bindHeader();
            }
            finally
            {
                if (reload)
                {
                    if (MediaPurchaseAdded)
                    {
                        Response.Redirect(String.Format("edit.aspx?p={0}{1}&mp=1", aPurchase.PurchaseID, GetFullID), true);
                    }
                    else
                    {
                        Response.Redirect(String.Format("edit.aspx?p={0}{1}", aPurchase.PurchaseID, GetFullID), true);
                    }
                }
                else
                {
                    if (aPurchase != null)
                    {
                        bindItems(true);
                        BindTaxDropDown(dTax, AccountType.E_AccountType.EXPENSE);//need to bind this again to keep rate attr         
                        validateTaxSelectedValue(db, dTax, LocationDefaultTaxGroup.TaxForPurchaseItems);

                        BindTaxDropDown(dTaxEdit, AccountType.E_AccountType.EXPENSE);//need to bind this again to keep rate attr         
                        validateTaxSelectedValue(db, dTaxEdit, LocationDefaultTaxGroup.TaxForPurchaseItems);
                        updateMessage(true, "updated");
                    }
                }
            }
        }

        public static byte[] ReadFully(System.IO.Stream input)
        {
            byte[] buffer = new byte[16 * 1024];
            using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
            {
                int read;
                while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                {
                    ms.Write(buffer, 0, read);
                }
                return ms.ToArray();
            }
        }

        public void AddEvent(Location location, User user, String Event, String purchaseID, IApplicationEntities db)
        {
            ApplicationEntities Context = new ApplicationEntities();
            Razoom.Model.EventHistory aEventHistory = new Razoom.Model.EventHistory();
            aEventHistory.LocationID = location.LocationID;
            aEventHistory.PurchaseID = aPurchase.PurchaseID;
            aEventHistory.ContactID = this.ContactID;
            aEventHistory.AddedUserID = user.UserID;
            aEventHistory.AddedDate = System.DateTime.UtcNow;
            aEventHistory.Event = Event;
            Razoom.Model.Item aItemJob = db.Items.Where(w => w.PurchaseID == aPurchase.PurchaseID && w.JobID != null).FirstOrDefault();
            if (aItemJob != null)
                aEventHistory.JobID = aItemJob.JobID;
            //NEED TO GET RepairID IF EXISTS
            Razoom.Model.Item aItemRepair = db.Items.Where(w => w.PurchaseID == aPurchase.PurchaseID && w.RepairID != null).FirstOrDefault();
            if (aItemRepair != null)
                aEventHistory.RepairID = aItemRepair.RepairID;
            //NEED TO GET StockID IF EXISTS
            Razoom.Model.Item aItemStock = db.Items.Where(w => w.PurchaseID == aPurchase.PurchaseID && w.StockID != null).FirstOrDefault();
            if (aItemStock != null)
                aEventHistory.StockID = aItemStock.StockID;
            db.EventHistories.Add(aEventHistory);
            db.SaveChanges(user, location);
        }
        void bEmailCust_Click(object sender, EventArgs e)
        {
            if (AuthDetail.User.Approved)
            {
                string a = tbemailBody.Text.Replace("\r\n", "<br/>").Replace("\r", "<br/>").Replace("\n", "<br/>");
                keepDB = true;
                Task.Run(() => aPurchase.email(MyLocation.Container, a, MyLocation, tbemailtop.Text, tbEmailbcc.Text, AuthDetail.User, tbSubject.Text, lAttch.Text, db, false));

                updateMessage(true, "emailsent");
            }
            else
                updateMessage(false, "unverifiedusercantemail");

        }

        //Email when deleteing
        void lbsendEmail_Click(object sender, EventArgs e)
        {
            if (aPurchase.PurchaseDocument != null)
            {
                System.IO.Stream BlobStream = new System.IO.MemoryStream();
                aPurchase.CloudBlob.DownloadToStream(BlobStream);
                BlobStream.Seek(0, System.IO.SeekOrigin.Begin);

                string encodedData = System.Convert.ToBase64String(ReadFully(BlobStream));
                String docuName = AuthDetail.AuthLocation.Container.ApplicationName + Razoom.Resources.forms.Forms.purchase + "_" + aPurchase.Number + ".pdf";
                String subject = String.Format("CarVue {0} ", Razoom.Resources.forms.Forms.purchasedocument);
                EmailSender.sendAttachmentEmail(AuthDetail.User, MyLocation.Container, tbEmail.Text, encodedData, docuName, MyLocation.Name, subject);

                updateMessage(true, "emailsent");
                String events = String.Format("{1} {0}", tbEmail.Text, Razoom.Resources.forms.Forms.purchaseemailedto);
                aPurchase.addEvent(MyLocation, AuthDetail.User, events);
                SaveChanges();
            }
            else
            {
                updateMessage(false, "emailfailed");
            }
        }

        private void btnDeleteLineItem_Click(object sender, EventArgs e)
        {
            try
            {
                decimal oldLineItemTotal = 0,
               newLineItemTotal = 0;
                string lineItemId = hiddenItemID.Value;
                oldLineItemTotal = lTot.Text == "" ? 0 : Convert.ToDecimal(lTot.Text);
                IItemContainerRemovePurchaseLineItem ItemContainerRemoveItem = aPurchase;
                ItemContainerRemoveItem.removePurchaseLineItem(db, AuthDetail.User, AuthDetail.Location, Int32.Parse(lineItemId), aPurchase.PurchaseID, aPurchase.PurchaseTransactionTypeID, aPurchase.JobID);
                bindItems();
                string lineItemDescription = tService.Text;
                newLineItemTotal = aPurchase.total;

                string eventPurchaseTotalChange = string.Empty, eventLineItemDelete = string.Empty;

                if (aPurchase.PurchaseTransactionTypeID == Razoom.Model.PurchaseTransactionType.PurchaseCredit)
                {
                    eventPurchaseTotalChange = String.Format(Razoom.Resources.forms.Forms.purchasecredittotalchangevent, oldLineItemTotal, newLineItemTotal);
                    eventLineItemDelete = String.Format(Razoom.Resources.forms.Forms.lineitemdeletedevent, lineItemDescription);
                }
                else
                {
                    eventPurchaseTotalChange = String.Format(Razoom.Resources.forms.Forms.purchasetotalchangevent, oldLineItemTotal, newLineItemTotal);
                    eventLineItemDelete = String.Format(Razoom.Resources.forms.Forms.lineitemdeletedevent, lineItemDescription);
                }
                //String events = String.Format("{1} {0} {2}", Razoom.Resources.forms.Forms.invoicejoblineitems, lineItemId, Razoom.Resources.forms.Forms.deleted);
                if (oldLineItemTotal != newLineItemTotal)
                {
                    eventLineItemDelete += "<br>" + eventPurchaseTotalChange;
                }
                if (spanUnPaid.Visible)
                {
                    AddEvent(AuthDetail.Location, AuthDetail.User, eventLineItemDelete, aPurchase.PurchaseID, db);
                }
                updateMessage(true, "updated");
            }
            catch (Exception)
            {
                updateMessage(false, "faileddelete");
            }
        }

    }
}