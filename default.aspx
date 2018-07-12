<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Pages/standard.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="carvue.purchase._default" %>

<asp:Content ID="c1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="c2" ContentPlaceHolderID="cp" runat="server">
    <div class="panel-head">
        <header>
            <div class="row">
                <div class="medium-4 small-12 columns">
                    <h1>
                    <i class="icon-cv-purchase"></i> 
                    <%= Razoom.Resources.forms.Forms.purchases %>
                    </h1>
                </div>
                <div class="medium-8 small-12 columns">
                    <ul class="inline-list pull-right">
                        <li>
                            <a href="edit.aspx?ptt=8115C243-1CF3-4E65-ADE1-64F554D8A147" class="button success requiredNav"><i class="icon-add"></i></a>
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
                            <a href="edit.aspx?ptt=C5EA6E1D-4345-4F87-BA2B-5280B874E6C7"><i class="icon-add"></i><%= Razoom.Resources.forms.Forms.newpurchasecreditnote %></a>
                        </li>
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
        <raz:autoSearch id="search" runat="server" />
        <section>
            <div class="row">
                <div class="large-3 medium-6 columns">
                    <div class="sparkline-wrapper plain">
                        <div class="summary centered">
                            <h6>
                                <%= Razoom.Resources.forms.Forms.draftpurchase %></h6>
                            <span>
                                <asp:Literal ID="lDraft" runat="server" />
                            </span>
                            <small>
                                <%= Razoom.Resources.forms.Forms.total %>
                            </small>
                        </div>
                    </div>
                </div>
                <div class="large-3 medium-6 columns">
                    <div class="sparkline-wrapper plain">
                        <div class="graph sparkline-bar-good">
                            <span>
                                0,<asp:Literal ID="lArrPurchase" runat="server" />
                            </span>
                            <small><%= Razoom.Resources.forms.Forms.last6months %></small>
                        </div>
                        <div class="summary">
                            <h6>
                                <%= Razoom.Resources.forms.Forms.purchases %></h6>
                            <span>
                                <a href="../report/accounts/totalPurchase.aspx"><asp:Literal ID="lPurchaseThisMonth" runat="server" /></a>
                            </span>
                            <small><%= Razoom.Resources.forms.Forms.thismonth %></small>
                        </div>
                    </div>
                </div>
                <div class="large-3 medium-6 columns">
                    <div class="sparkline-wrapper plain">
                        <div class="summary centered">
                            <h6>
                                <%= Razoom.Resources.forms.Forms.unpaid %> <%= Razoom.Resources.forms.Forms.purchase %>
                            </h6>
                            <span>
                                <a href="../report/accounts/agedCreditors.aspx"><asp:Literal ID="lUnPaid" runat="server" /></a>
                            </span>
                            <small><%= Razoom.Resources.forms.Forms.total %></small>
                        </div>
                    </div>
                </div> 
                 <div class="large-3 medium-6 columns">
                    <div class="sparkline-wrapper plain">
                        <div class="summary centered">
                            <h6>
                                <%= Razoom.Resources.forms.Forms.unpaid %> <%= Razoom.Resources.forms.Forms.purchasecredit %>
                            </h6>
                            <span>
                                <a href="../report/accounts/agedCreditors.aspx">
                                    <asp:Literal ID="lUnPaidCredit" runat="server" /></a></span>
                            <small>
                                <%= Razoom.Resources.forms.Forms.purchasecredits %>
                            </small>
                        </div>
                    </div>
                </div>               
            </div>
        </section>
    </div>
    <div class="row">
        <div class="medium-12 columns">
            <ul class="inline-list filters">
                <li>
                    <a href="#Recent" class="button filter FilterGroup1 Recent active" onclick="reInitDataTable('Recent');"><%= Razoom.Resources.forms.Forms.recent %></a>
                </li>
                <li>
                    <a href="#Draft" class="button filter FilterGroup1 Draft" onclick="reInitDataTable('Draft');"><%= Razoom.Resources.forms.Forms.draftpurchase %></a>
                </li>
                <li>
                    <a href="#Purchase" class="button filter FilterGroup1 Purchase" onclick="reInitDataTable('Purchase');"><%= Razoom.Resources.forms.Forms.purchase %></a>
                </li>
                <li>
                    <a href="#DraftCredit" class="button filter FilterGroup1 DraftCredit" onclick="reInitDataTable('DraftCredit');"><%= Razoom.Resources.forms.Forms.draftpurchasecredit %></a>
                </li>
                <li>
                    <a href="#Credit" class="button filter FilterGroup1 Credit" onclick="reInitDataTable('Credit');"><%= Razoom.Resources.forms.Forms.purchasecredit %></a>
                </li>
                 <li>
                    <a href="#UnPaidPurchase" class="button filter FilterGroup1 UnPaidPurchase" onclick="reInitDataTable('UnPaidPurchase');"><%= Razoom.Resources.forms.Forms.unpaidpurchase %></a>
                </li>
                <li>
                    <a href="#UnPaidCredit" class="button filter FilterGroup1 UnPaidCredit" onclick="reInitDataTable('UnPaidCredit');"><%= Razoom.Resources.forms.Forms.unpaidpurchasecredit %></a>
                </li>
                <li>
                    <div class="dataTables-spinner small">&nbsp; &nbsp; &nbsp; </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="row">
        <div class="large-12 columns">
            <table class="dataTables" id="purchaseTable">
                <caption>
                    <asp:Label ID="lHeader" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.recent  %>" />
                </caption>
                <thead>
                    <tr>
                    </tr>
                </thead>
                <tbody>
                </tbody>
                <tfoot class="totFoot">
                    <tr>                        
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
                </tfoot>
            </table>
            <div class="dataTables-spinner"></div>
        </div>
    </div>
    <%--END--%>
    <br>
    <br>
    <input type="hidden" class="mxp" id="hfPage" value="Purchase: Dashboard Viewed">
</asp:Content>
<asp:Content ID="c3" ContentPlaceHolderID="cpFoot" runat="server">
    <script src="../assets/js/jquery.dataTables.odata.js"></script>
    <script type="text/javascript">

        var sSearch = "(LocationID eq " + LocationID + ")";
        var sAjaxSource = "/Services/DataService.svc/Purchases";
        var Purchase = "8115C243-1CF3-4E65-ADE1-64F554D8A147";
        var PurchaseCredit = "C5EA6E1D-4345-4F87-BA2B-5280B874E6C7";
        var showFooter = false;

        function queryDataTable(Type)
        {
            var header = $('#cp_lHeader');
            $("a.FilterGroup1").removeClass("active");
            $("a." + Type + " ").addClass("active");
            switch (Type) {               
                case "Recent":
                    sSearch = "(LocationID eq " + LocationID + ")";
                    sAjaxSource = "/Services/DataService.svc/Purchases";
                    header.html("<%= Razoom.Resources.forms.Forms.recent %>");
                    showFooter = false;
                    break;
                case "Draft":
                    sSearch = "(LocationID eq " + LocationID + ") and (PurchaseTransactionTypeID eq '" + Purchase + "') and (PurchaseDocument eq null)";
                    sAjaxSource = "/Services/DataService.svc/Purchases";
                    header.html("<%= Razoom.Resources.forms.Forms.draftpurchase %>");
                    showFooter = true;
                    break;
                case "Purchase":
                    sSearch = "(LocationID eq " + LocationID + ") and (PurchaseTransactionTypeID eq '" + Purchase + "') and (PurchaseDocument ne null)";
                    sAjaxSource = "/Services/DataService.svc/Purchases";
                    header.html("<%= Razoom.Resources.forms.Forms.purchase %>");
                    showFooter = false;
                    break;             
                case "DraftCredit":
                    sSearch = "(LocationID eq " + LocationID + ") and (PurchaseTransactionTypeID eq '" + PurchaseCredit + "') and (PurchaseDocument eq null)";
                    sAjaxSource = "/Services/DataService.svc/Purchases";
                    header.html("<%=Razoom.Resources.forms.Forms.draftpurchasecredit%>");
                    showFooter = true;
                    break;
                case "Credit":
                    sSearch = "(LocationID eq " + LocationID + ") and (PurchaseTransactionTypeID eq '" + PurchaseCredit + "') and (PurchaseDocument ne null)";
                    sAjaxSource = "/Services/DataService.svc/Purchases";
                    header.html("<%=Razoom.Resources.forms.Forms.purchasecredit%>");
                    showFooter = false;
                    break;
                case "UnPaidPurchase":
                    sSearch = "(LocationID eq " + LocationID + ") and (PurchaseTransactionTypeID eq '" + Purchase + "') and (PurchaseDocument ne null)";
                    sAjaxSource = "/Services/DataService.svc/PurchasesUnPaid";
                    header.html("<%=Razoom.Resources.forms.Forms.unpaidpurchase%>");
                    showFooter = true;
                    break;
                case "UnPaidCredit":
                    sSearch = "(LocationID eq " + LocationID + ") and (PurchaseTransactionTypeID eq '" + PurchaseCredit + "') and (PurchaseDocument ne null)";
                    sAjaxSource = "/Services/DataService.svc/PurchasesUnPaid";
                    header.html("<%=Razoom.Resources.forms.Forms.unpaidpurchasecredit%>");
                    showFooter = true;
                    break;
                default:
                    sSearch = "(LocationID eq " + LocationID + ")";
                    sAjaxSource = "/Services/DataService.svc/Purchases";
                    header.html("<%= Razoom.Resources.forms.Forms.recent %>");
                    showFooter = false;
                    break;
            }
        }

        function reInitDataTable(Type) {
            var oTable = $('#purchaseTable').dataTable();            
            var oSettings = oTable.fnSettings();
            queryDataTable(Type);
            oSettings.sAjaxSource = sAjaxSource;
            oSettings.oInit.sSearch = sSearch;
            oTable.fnDraw();
        }

            function purchaseDataTable() {
                dTableInfo.bProcessing = true;
                dTableInfo.bServerSide = true;
                dTableInfo.expand = "PurchaseDocument, Contact, Location, AddedUser, Items, Items/Account, Items/TaxGroup, Items/TaxGroup/TaxTypes, Items/Allocation";
                dTableInfo.aaSorting = [[4, "desc"]];
                dTableInfo.aoColumns = [                
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
                        "sTitle": "<%= Razoom.Resources.forms.Forms.value %>", sName: "Items", "sClass": "text-right val", "mData": "Items", sType: 'string', 'bSortable': false, "mRender": function (data, type, full) {
                            if (full.PurchaseTransactionTypeID == Purchase)
                                return Globalize.format(sumItemTotal(full.Items) * -1, "c");
                            else
                                return Globalize.format(sumItemTotal(full.Items), "c");
                        }
                    },
                    {
                        "sTitle": "<%= Razoom.Resources.forms.Forms.paid %>", sName: "Items", "sClass": "text-right paidv", "mData": "Items", sType: 'string', 'bSortable': false, "mRender": function (data, type, full) {
                            return Globalize.format(sumItemPayments(full.Items), "c");
                        }
                    },
                    {
                        "sTitle": "<%= Razoom.Resources.forms.Forms.due %>", sName: "Items", "sClass": "text-right due", "mData": "Items", sType: 'string', 'bSortable': false, "mRender": function (data, type, full) {
                            r = sumItemOwed(full.Items) * -1;
                            return Globalize.format(r, "c");
                        }
                    },
                   {
                       "sTitle": "<%= Razoom.Resources.forms.Forms.type %>", sName: "PurchaseTransactionTypeID", "mData": "PurchaseTransactionTypeID", sType: "string", 'bSortable': false, "mRender": function (data, type, full) {
                           if (full.PurchaseDocument != null && data == PurchaseCredit) {
                            return "<%= Razoom.Resources.forms.Forms.purchasecredit %>";
                        }
                           else if (full.PurchaseDocument != null && data == Purchase) {
                            return "<%= Razoom.Resources.forms.Forms.purchase %>";
                        }              
                           else if (full.PurchaseDocument == null && data == PurchaseCredit) {
                            return "<%= Razoom.Resources.forms.Forms.draft %> <%= Razoom.Resources.forms.Forms.purchasecredit %>";
                        }
                           else if (full.PurchaseDocument == null && data == Purchase) {
                            return "<%= Razoom.Resources.forms.Forms.draft %> <%= Razoom.Resources.forms.Forms.purchase %>";
                            }
                       }
                   },
                    {
                        "sTitle": "", "mData": "JobID", sType: "string", 'bSortable': false, "mRender": function (data, type, full) {
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
                dTableInfo.fnDrawCallback = function (oSettings, json) {
                    //TOTALS FOR FOOTER AFTER TABLE AS RENDERED
                    if (showFooter) {
                        $('.totFoot').show();
                        var totalVal = 0; var totalPaid = 0; var totalDue = 0;
                        if (typeof culture != 'undefined') {
                            Globalize.culture(culture).numberFormat.currency.symbol = "";
                        }
                        $.each($('td.val'), function (index, value) {
                            var c = value.innerHTML.replace("&nbsp;", " ");
                            while (c.search("&nbsp;") > 0) {
                                c = c.replace("&nbsp;", " ");
                            }
                            var v = Globalize.parseFloat(c);
                            totalVal += v;
                        });
                        $.each($('td.paidv'), function (index, value) {
                            var c = value.innerHTML.replace("&nbsp;", " ");
                            while (c.search("&nbsp;") > 0) {
                                c = c.replace("&nbsp;", " ");
                            }
                            var v = Globalize.parseFloat(c);
                            totalPaid += v;
                        });
                        $.each($('td.due'), function (index, value) {
                            var c = value.innerHTML.replace("&nbsp;", " ");
                            while (c.search("&nbsp;") > 0) {
                                c = c.replace("&nbsp;", " ");
                            }
                            var v = Globalize.parseFloat(c);
                            totalDue += v;
                        });
                        $('th.Fval').text(Globalize.format(totalVal, "c"));
                        $('th.Fpaid').text(Globalize.format(totalPaid, "c"));
                        $('th.Fdue').text(Globalize.format(totalDue, "c"));
                        $('th.totl').text('<%= Razoom.Resources.forms.Forms.total %>');
                    }
                    else { $('.totFoot').hide(); }

                    $(".dataTables-spinner").hide(); //NEEDS TO BE CALLED AS THIS WILL OVERRIDE THE DRAWCALLBACK IN RAZOOM BASE                
                }
                dTableInfo.sAjaxSource = sAjaxSource;
                dTableInfo.sSearch = sSearch;
                dTableInfo.fnServerData = fnServerOData;
                dTableInfo.iODataVersion = 3;
                dTableInfo.bUseODataViaJSONP = true;
                dTableInfo.select = "PurchaseID, PurchaseDocument/PurchaseID, StockID, AddedUser/Firstname";
            
                $('#purchaseTable').dataTable(dTableInfo);
                $('#thetable_filter input').attr('id', 'myId');
            }

            function initBind(query)
            {
                if (query != "") {                           
                    reInitDataTable(query);
                }
                else
                {
                    $("a.Recent").addClass("active");
                }
            }

            $(function () {
                var query = window.location.hash.replace('#', '');
                if (query != null && query != "")
                {
                    queryDataTable(query);
                }
                purchaseDataTable();
            });

    </script>
</asp:Content>
