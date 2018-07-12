<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Pages/standard.Master" AutoEventWireup="true" CodeBehind="search.aspx.cs" Inherits="carvue.purchase._search" %>

<asp:Content ID="c1" ContentPlaceHolderID="head" runat="server">

</asp:Content>
<asp:Content ID="c3" ContentPlaceHolderID="cp" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <div class="panel-head">
                <header>
                    <div class="row">
                        <div class="medium-4 small-12 columns">
                            <a href="#" class="back-button button pull-left requiredNav">
                                <i class="icon-angle-left"></i>
                            </a>
                            <h1>
                                <i class="icon-cv-purchase"></i> 
                                <%= Razoom.Resources.forms.Forms.searchpurchases %>
                            </h1>
                        </div>
                        <div class="medium-8 small-12 columns">
                            <ul class="inline-list pull-right">
                                <li>
                                    <a href="edit.aspx" class="button success requiredNav"><i class="icon-add"></i></a>
                                </li>                        
                                 <li>
                                    <div class="qBtn">
                                        <a href="javascript:;" class="button secondary requiredNav"><i class="icon-search"></i></a>
                                    </div>                            
                                    <div class="qMedium"></div>
                                </li>                       
                                 <li>
                                    <a href="javascript:;" data-dropdown="dropNav" class="button secondary requiredNav"><i class="icon-angle-down"></i></a>
                                </li>
                            </ul>
                            <ul id="dropNav" class="f-dropdown content" data-dropdown-content>
                                <li>
                                    <a href="search.aspx"><i class="icon-search"></i> <%= Razoom.Resources.forms.Forms.search %></a>
                                </li>
                                <li>
                                    <a href="../report/accounts/"><i class="icon-cv-report"></i> <%= Razoom.Resources.forms.Forms.reports %></a>
                                </li>
                            </ul>                    
                        </div>
                        <div class="qSmall"></div>
                    </div>
                </header> 
            </div>


            <raz:autoSearch ID="search" runat="server" />


            <div class="row">
                <div class="large-12 columns">
                    <div class="panel-form">
                        <section>
                            <div class="row">
                                <div class="medium-5 columns">
                                    <div class="sub-panel">
                                        <header>
                                            <%= Razoom.Resources.forms.Forms.invoice %>
                                        </header>
                                        <section>
                                            <div class="row">
                                                <div class="medium-5 columns">
                                                    <label class="inline" for=""><%= Razoom.Resources.forms.Forms.reference %></label>  
                                                </div>
                                                <div class="medium-7 columns">
                                                    <asp:TextBox ID="tRef" runat="server" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="medium-5 columns">
                                                    <label class="inline" for=""><%= Razoom.Resources.forms.Forms.supplier %></label>  
                                                </div>
                                                <div class="medium-7 columns">
                                                    <asp:TextBox ID="tSupplier" runat="server" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="medium-5 columns">
                                                    <label class="inline"><%= Razoom.Resources.forms.Forms.number %></label>  
                                                </div>
                                                <div class="medium-7 columns">
                                                    <asp:TextBox ID="tNumber" runat="server" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="medium-5 columns">
                                                    <label class="inline" for=""><%= Razoom.Resources.forms.Forms.type %></label>  
                                                </div>
                                                <div class="medium-7 columns">
                                                    <asp:DropDownList runat="server" ID="ddlType" CssClass="select2" DataTextField="Name" DataValueField="InvoiceTransactionTypeID" AppendDataBoundItems="True" >
                                                        <asp:ListItem Text="<%$ Code:Razoom.Resources.forms.Forms.purchaseinvoice %>"></asp:ListItem>    
                                                        <asp:ListItem Text="<%$ Code:Razoom.Resources.forms.Forms.draft %>"></asp:ListItem>    
                                                    </asp:DropDownList>
                                                    
                                                </div>
                                            </div>
                                            <div class="row advancedSearch hide">
                                                <div class="medium-5 columns">
                                                    <label class="inline"><%= Razoom.Resources.forms.Forms.purchasedby %></label>  
                                                </div>
                                                <div class="medium-7 columns">
                                                    <asp:TextBox ID="tPurchasedBy" runat="server" />
                                                </div>
                                            </div>
                                            <div class="row advancedSearch hide">
                                                <div class="medium-5 columns">
                                                    <label class="inline" for=""><%= Razoom.Resources.forms.Forms.addedby %></label>  
                                                </div>
                                                <div class="medium-7 columns">
                                                    <asp:TextBox ID="tAddedBy" runat="server" />
                                                </div>
                                            </div>
                                            <%--<div class="row advancedSearch hide">
                                                <div class="medium-5 columns">
                                                    <label class="inline" for=""><%= Razoom.Resources.forms.Forms.paid %></label>  
                                                </div>
                                                <div class="medium-7 columns">
                                                    <select name="" id="" class="select2"></select>
                                                </div>
                                            </div>--%>
                                             <div class="row advancedSearch hide">
                                                    <div class="medium-5 columns">
                                                        <label class="inline" for=""><%= Razoom.Resources.forms.Forms.jobno %></label>  
                                                    </div>
                                                    <div class="medium-7 columns">
                                                        <asp:TextBox ID="tJobno" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row advancedSearch hide">
                                                    <div class="medium-5 columns">
                                                        <label class="inline" for=""><%= Razoom.Resources.forms.Forms.stockno %></label>  
                                                    </div>
                                                    <div class="medium-7 columns">
                                                        <asp:TextBox ID="tStockno" runat="server" />
                                                    </div>
                                                </div>

                                        </section>
                                    </div>
                                    
                                </div>
                                <div class="medium-7 columns">
                                     <div class="sub-panel">
                                            <header>
                                                <%= Razoom.Resources.forms.Forms.date %>
                                            </header>
                                            <section>
                                                <div class="row">
                                                    <div class="medium-4 columns">
                                                        <label class="inline" for=""><%= Razoom.Resources.forms.Forms.date %></label>  
                                                    </div>
                                                    <div class="medium-4 columns">
                                                        <asp:TextBox runat="server" ID="tDateFrom" type="text" class="datepicker" placeholder="<%$ Code:Razoom.Resources.forms.Forms.from  %>" />
                                                    </div>
                                                    <div class="medium-4 columns">
                                                        <asp:TextBox runat="server" ID="tDateTo" type="text" class="datepicker" placeholder="<%$ Code:Razoom.Resources.forms.Forms.to  %>" />
                                                    </div>
                                                </div>
                                                <div class="row advancedSearch hide">
                                                    <div class="medium-4 columns">
                                                        <label class="inline" for=""><%= Razoom.Resources.forms.Forms.updated %></label>  
                                                    </div>
                                                    <div class="medium-4 columns">
                                                        <asp:TextBox runat="server" ID="tDueFrom" type="text" class="datepicker" placeholder="<%$ Code:Razoom.Resources.forms.Forms.from  %>" />
                                                    </div>
                                                    <div class="medium-4 columns">
                                                        <asp:TextBox runat="server" ID="tDueTo" type="text" class="datepicker" placeholder="<%$ Code:Razoom.Resources.forms.Forms.to  %>" />
                                                    </div>
                                                </div>
                                                <div class="row advancedSearch hide">
                                                    <div class="medium-4 columns">
                                                        <label class="inline" for=""><%= Razoom.Resources.forms.Forms.added %></label>  
                                                    </div>
                                                    <div class="medium-4 columns">
                                                        <asp:TextBox runat="server" ID="tAddedFrom" type="text" class="datepicker" placeholder="<%$ Code:Razoom.Resources.forms.Forms.from  %>" />
                                                    </div>
                                                    <div class="medium-4 columns">
                                                        <asp:TextBox runat="server" ID="tAddedTo" type="text" class="datepicker" placeholder="<%$ Code:Razoom.Resources.forms.Forms.to  %>" />
                                                    </div>
                                                </div>

                                            </section>
                                        </div>
                                    
                                   <%-- <div class="sub-panel advancedSearch hide">
                                        <header>
                                            <%= Razoom.Resources.forms.Forms.value %>
                                        </header>
                                        <section>
                                            <div class="row">
                                                <div class="medium-4 columns">
                                                    <label class="inline" for=""><%= Razoom.Resources.forms.Forms.total %></label>  
                                                </div>
                                                <div class="medium-4 columns">
                                                    <input type="text" placeholder="Replace this placeholder">
                                                </div>
                                                <div class="medium-4 columns">
                                                    <input type="text" placeholder="Replace this placeholder">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="medium-4 columns">
                                                    <label class="inline" for=""><%= Razoom.Resources.forms.Forms.paid %></label>  
                                                </div>
                                                <div class="medium-4 columns">
                                                    <input type="text" placeholder="Replace this placeholder">
                                                </div>
                                                <div class="medium-4 columns">
                                                    <input type="text" placeholder="Replace this placeholder">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="medium-4 columns">
                                                    <label class="inline" for=""><%= Razoom.Resources.forms.Forms.due %></label>  
                                                </div>
                                                <div class="medium-4 columns">
                                                    <input type="text" placeholder="Replace this placeholder">
                                                </div>
                                                <div class="medium-4 columns">
                                                    <input type="text" placeholder="Replace this placeholder">
                                                </div>
                                            </div>

                                        </section>
                                    </div>--%>
                                    
                                </div>
                            </div>
                        </section>    
                        <footer class="offset text-right">
                              <a href="javascript:clearTB();" class="button large plain toggleExpandCollapse toggleShowHideClass noFade" target-class="advancedSearch"><i class="icon-expand"></i> <%= Razoom.Resources.forms.Forms.advancedsearch %></a>
                               <asp:Button ID="Button1" runat="server" class="button success large" Text="<%$ Code:Razoom.Resources.forms.Forms.search  %>" OnClientClick="searchPurchase(); return false;" />
                        </footer>

                    </div>
                </div>
            </div>



            <div class="row">
                <div class="large-12 columns">
                    <table class="dataTables" id="purchaseTable">
                        <caption>
                            <asp:Literal ID="Literal29" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.purchases  %>" /></caption>
                        <thead>
                            <tr>
                                <%--<th>Results</th>--%>
                            </tr>
                        </thead>
<%--                                           <tfoot>
                            <tr>
                                <th>&nbsp;</th>
                                <th class="totl"><%= Razoom.Resources.forms.Forms.total %>:&nbsp;</th>
                                <th>&nbsp;</th>
                                <th>&nbsp;</th>
                                <th>&nbsp;</th>
                                <th>&nbsp;</th>
                                <th class="Fval">&nbsp;</th>
                                <th class="Fpaid">&nbsp;</th>
                                <th class="Fdue">&nbsp;</th>
                                <th>&nbsp;</th>
                                <th>&nbsp;</th>
                            </tr>
                        </tfoot>--%>
                    </table>
                    <div class="dataTables-spinner"></div>
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>

<asp:Content ID="foot" runat="server" ContentPlaceHolderID="cpFoot">

    <script src="../assets/js/jquery.dataTables.odata.js"></script>

    <script type="text/javascript">

        function clearTB() {
            $('[id*="tAddedFrom"]').val("");
            $('[id*="tAddedTo"]').val("");
            $('[id*="tDueFrom"]').val("");
            $('[id*="tDueTo"]').val("");
            $('[id*="tStockno"]').val("");
            $('[id*="tJobno"]').val("");
        }

        var purchaseDTableInfo = dTableInfo;

        var pNumber = "";
        var Supplier = "";
        var DateFrom = "";
        var DateTo = "";
        var Reference = "";
        var PurchasedBy = "";
        var AddedBy = "";
        var Type = "";
        var JobNo = "";
        var StockNo = "";
        var DateFrom = "";
        var DueFrom = "";
        var DueTo = "";
        var AddedFrom = "";
        var AddedTo = "";

        var basesearch = "(Location/BillingAccountID eq '" + BillingAccountID + "')";

        function searchPurchase() {
            var tDateFrom = document.getElementById('<%=tDateFrom.ClientID%>').value;
            if (tDateFrom.length > 0) {
                DateFrom = " and (PurchaseDate ge datetime'" + moment.tz(tDateFrom, DateFormatMoment, Iana).toJSON() + "')";
            } else {
                DateFrom = "";
            }
            var tDateTo = document.getElementById('<%=tDateTo.ClientID%>').value;
            if (tDateTo.length > 0) {
                DateTo = " and (PurchaseDate le datetime'" + moment.tz(tDateTo, DateFormatMoment, Iana).add('d', 1).toJSON() + "')";
            } else {
                DateTo = "";
            }
           
            var tPurchasedBy = document.getElementById('<%=tPurchasedBy.ClientID%>').value;
            if (tPurchasedBy.length > 0) {
                PurchasedBy = " and (substringof('" + tPurchasedBy + "', PurchaseUser/Firstname)) or (substringof('" + tPurchasedBy + "', PurchaseUser/Lastname))";
            } else {
                PurchasedBy = "";
            }
            var tNumber = document.getElementById('<%=tNumber.ClientID%>').value;
            if (tNumber.length > 0) {
                pNumber = " and (substringof('" + tNumber + "', Number))";
            } else {
                pNumber = "";
            }
            var tSupplier = document.getElementById('<%=tSupplier.ClientID%>').value;
            if (tSupplier.length > 0) {
                Supplier = " and (substringof('" + tSupplier + "', Contact/Name))";
            } else {
                Supplier = "";
            }
            var ddlType = document.getElementById('<%=ddlType.ClientID%>');
            var d = ddlType.options[ddlType.selectedIndex];
            if (d.index === 1) {
                Type =  "and (PurchaseDocument ne null)";
            } else if (d.index === 2) {
                Type = " and (PurchaseDocument eq null)";
            }
            var tAddedBy = document.getElementById('<%=tAddedBy.ClientID%>').value;
            if (tAddedBy.length > 0) {
                AddedBy = " and ((substringof('" + tAddedBy + "', AddedUser/Firstname)) or (substringof('" + tAddedBy + "', AddedUser/Lastname)))";
            } else {
                AddedBy = "";
            }
            var tRef = document.getElementById('<%=tRef.ClientID%>').value;
            if (tRef.length > 0) {
                Reference = " and (substringof('" + tRef + "', Reference))";
            } else {
                Reference = "";
            }
            var tJobno = document.getElementById('<%=tJobno.ClientID%>').value;
            if (tJobno.length > 0) {
                JobNo = " and (substringof('" + tJobno + "', Reference))";//JOB NO
            } else {
                JobNo = "";
            }
            var tStockno = document.getElementById('<%=tStockno.ClientID%>').value;
            if (tStockno.length > 0) {
                StockNo = " and (substringof('" + tStockno + "', Reference))";//Stock No
            } else {
                StockNo = "";
            }
           var tDueFrom = document.getElementById('<%=tDueFrom.ClientID%>').value;
            if (tDueFrom.length > 0) {
                DueFrom = " and (UpdatedDate ge datetime'" + moment.tz(tDueFrom, DateFormatMoment, Iana).toJSON() + "')";
            } else {
                DueFrom = "";
            }
            var tDueTo = document.getElementById('<%=tDueTo.ClientID%>').value;
            if (tDueTo.length > 0) {
                DueFrom = " and (UpdatedDate le datetime'" + moment.tz(tDueTo, DateFormatMoment, Iana).add('d', 0).toJSON() + "')";
            } else {
                DueFrom = "";
            }
            var tAddedFrom = document.getElementById('<%=tAddedFrom.ClientID%>').value;
            if (tAddedFrom.length > 0) {
                AddedFrom = " and (AddedDate ge datetime'" + moment.tz(tAddedFrom, DateFormatMoment, Iana).toJSON() + "')";
            } else {
                AddedFrom = "";
            }
            var tAddedTo = document.getElementById('<%=tAddedTo.ClientID%>').value;
            if (tAddedTo.length > 0) {
                AddedTo = " and (AddedDate le datetime'" + moment.tz(tAddedTo, DateFormatMoment, Iana).add('d', 0).toJSON() + "')";
            } else {
                AddedTo = "";
            }

            //var result = basesearch.concat(DateFrom, DateTo, Supplier, PurchasedBy, pNumber, AddedBy, Reference);
            var result = basesearch.concat(pNumber, Supplier, DateFrom, DateTo, Reference, PurchasedBy, AddedBy, Type, JobNo, StockNo, DueFrom, DueFrom, DueTo, AddedFrom, AddedTo);

            purchaseDTableInfo.bDestroy = true;
            purchaseDTableInfo.bProcessing = true;
            purchaseDTableInfo.bServerSide = true;
            purchaseDTableInfo.sAjaxSource = "/Services/DataService.svc/Purchases";
            purchaseDTableInfo.expand = "PurchaseDocument, Contact, Items, AddedUser, PurchaseUser, Items/Account, Items/TaxGroup, Items/TaxGroup/TaxTypes";
            purchaseDTableInfo.aaSorting = [[2, "desc"]];
            purchaseDTableInfo.aoColumns = [                    
                    {
                        "sTitle": "<%= Razoom.Resources.forms.Forms.number %>", "mData": "Number", sType: "html", "mRender": function (data, type, full) {
                            return '<a href="../Purchase/edit.aspx?p=' + full.PurchaseID + '">' + data + '</a>';
                        }
                    },
                    { "sTitle": "<%= Razoom.Resources.forms.Forms.reference %>", sName: "Reference", "mData": "Reference", sType: "html" },
                    {
                        "sTitle": "<%= Razoom.Resources.forms.Forms.purchasedate %>", sName: "PurchaseDate", "mData": "PurchaseDate", sType: "string", "mRender": function (data, type, full) {
                            return moment.utc(data).tz(Iana).format(DateFormatMoment);
                        }
                    },
                    { "sTitle": "<%= Razoom.Resources.forms.Forms.supplier %>", sName: "Contact/Name", "mData": "Contact.Name", sType: "html" },
                    {
                        "sTitle": "<%= Razoom.Resources.forms.Forms.added %>", sName: "AddedDate", "mData": "AddedDate", sType: "string", "mRender": function (data, type, full) {
                            return moment.utc(data).tz(Iana).format(DateFormatMoment);
                        }
                    },
                    {
                        "sTitle": "<%= Razoom.Resources.forms.Forms.value %>", sName: "Items", "sClass": "text-right val", "mData": "Items", sType: 'string', "mRender": function (data, type, full) {
                            return Globalize.format(sumItemTotal(full.Items) * -1, "c");
                        }
                    },
                    {
                        "sTitle": "<%= Razoom.Resources.forms.Forms.paid %>", sName: "Items", "sClass": "text-right paidv", "mData": "Items", sType: 'string', "mRender": function (data, type, full) {
                            return Globalize.format(sumItemPayments(full.Items), "c");
                        }
                    },
                    {
                        "sTitle": "<%= Razoom.Resources.forms.Forms.due %>", sName: "Items", "sClass": "text-right due", "mData": "Items", sType: 'string', "mRender": function (data, type, full) {
                            r = sumItemTotal(full.Items) * -1 - sumItemPayments(full.Items);
                            return Globalize.format(r, "c");
                        }
                    },
                    {
                        "sTitle": "<%= Razoom.Resources.forms.Forms.type %>", sName: "PurchaseDocument", "mData": "PurchaseDocument", sType: "string", "mRender": function (data, type, full) {
                            if (full.PurchaseDocument != null) {
                                return "<%= Razoom.Resources.forms.Forms.purchase %>";
                            }
                            else {
                                return "<%= Razoom.Resources.forms.Forms.draft %>";
                            }
                        }
                    },
                    {
                        "sTitle": "", "mData": "JobID", sType: "string", "mRender": function (data, type, full) {
                            if (full.JobID != null) {
                                return '<span><a href="../workshop/edit.aspx?j=' + full.JobID + '"><i class="icon-cv-workshop"></i></a></span>';
                            }
                            if (full.StockID != null) {
                                return '<a href="../sales/edit.aspx?s=' + full.StockID + '"><i class="icon-cv-sales"></i></a>';
                            }
                            return "";
                        }
                    },
                    { "sTitle": "Stock", "mData": "StockID", "bVisible": false }
            ];
            purchaseDTableInfo.sSearch = result;
            purchaseDTableInfo.fnServerData = fnServerOData;
            purchaseDTableInfo.iODataVersion = 3;
            purchaseDTableInfo.bUseODataViaJSONP = true;
            purchaseDTableInfo.select = "PurchaseID";
            $('#purchaseTable').dataTable(purchaseDTableInfo);
        }
             
        $(function () {
            $('.dataTables-spinner').hide();
        });
    </script>
</asp:Content>



