<%@ Page Title="" Language="C#" MasterPageFile="~/Master_Pages/standard.Master" AutoEventWireup="true" CodeBehind="edit.aspx.cs" Inherits="carvue.shared.edit" %>

<asp:Content ID="c1" ContentPlaceHolderID="head" runat="server">
    <script>
        fullWidth = true;
    </script>
</asp:Content>
<asp:Content ID="c2" ContentPlaceHolderID="cp" runat="server">
    <div class="panel-head">
        <header>
            <div class="row">
                <div class="medium-4 small-12 columns">
                    <a href="#" class="back-button button pull-left requiredNav">
                        <i class="icon-angle-left"></i>
                    </a>
                    <h1>
                        <i class="icon-cv-purchase"></i>
                        <asp:Literal ID="lPurchNo" runat="server" />&nbsp; 
                        <asp:Literal ID="ldraft" runat="server" />
                    </h1>
                </div>
                <div class="medium-8 small-12 columns">
                    <ul class="inline-list pull-right">
                        <li>
                            <asp:Literal ID="newPurchaseHref" runat="server" />

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
                        <%--<li  id="lCreditNote" runat="server" visible="true">--%>
                        <li>
                            <a href="edit.aspx?ptt=C5EA6E1D-4345-4F87-BA2B-5280B874E6C7"><i class="icon-add"></i><%= Razoom.Resources.forms.Forms.newpurchasecreditnote %></a>
                        </li>
                        <li>
                            <a href="search.aspx"><i class="icon-search"></i><%= Razoom.Resources.forms.Forms.search %></a>
                        </li>
                        <li>
                            <a href="../report/accounts/"><i class="icon-cv-report"></i><%= Razoom.Resources.forms.Forms.reports %></a>
                        </li>
                    </ul>
                </div>
                <div class="qSmall"></div>
            </div>
        </header>
    </div>
    <raz:autoSearch ID="search" runat="server" />
    <div class="section-container tabs" data-section="tabs">
        <section class="active">
            <p class="title" data-section-title>
                <a href="#">
                    <%=Razoom.Resources.forms.Forms.details  %>
                </a>
            </p>
            <div class="content no-padding" data-section-content>
                <div class="panel-form">
                    <section>

                        <div class="row">
                            <div class="medium-4 medium-push-4 columns text-center">
                                <div class="row">
                                    <div class="small-12">
                                        <h3 style="text-transform: uppercase">
                                            <div id="hInvoicetype" runat="server">
                                                <asp:Literal ID="lHeader" runat="server" />
                                            </div>
                                        </h3>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="small-12">
                                        <p>
                                            <span runat="server" id="spanPaid" class="paid"><%=Razoom.Resources.forms.Forms.paid  %></span>
                                            <span runat="server" id="spanUnPaid" class="paid unpaid"><%=Razoom.Resources.forms.Forms.unpaid  %></span>
                                            <span runat="server" id="spanPartPaid" class="paid part-paid"><%=Razoom.Resources.forms.Forms.partpaid  %></span>
                                        </p>
                                        <hr class="show-for-small" />
                                    </div>
                                </div>

                            </div>
                            <div class="medium-4 medium-pull-4 columns">
                                <div class="row">
                                    <div class="large-12 columns">
                                        <h3 class="light">
                                            <i class="icon-cv-contact light"></i>
                                            <span>
                                                <asp:Label ID="lContact" runat="server"></asp:Label>
                                            </span>
                                        </h3>
                                        <p class="update-details hide">
                                            <small><a href="#" onclick="pullContact()"><i class="icon-refresh"></i><%=Razoom.Resources.forms.Forms.update  %><%=Razoom.Resources.forms.Forms.details  %></a></small><br>
                                            <br>
                                        </p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="large-12 columns">
                                    </div>
                                </div>

                                <div class="row collapse">
                                    <div class="large-1 medium-1 small-1 columns">
                                        <span class="prefix radius"><i class="icon-search"></i></span>
                                    </div>
                                    <div class="large-11 medium-11 small-11 columns">
                                        <asp:TextBox ID="tSup" runat="server" required data-abide-group="purchase" class="search-spinner" placeholder="<%$ Code:Razoom.Resources.forms.Forms.supplier %>" />
                                        <div id="divSupplier" class="acList"></div>
                                        <asp:HiddenField ID="hfContactID" runat="server" />
                                        <small class="error">
                                            <%=Razoom.Resources.validation.validation.description  %></small>
                                    </div>
                                </div>
                            </div>
                            <div class="medium-4 columns text-right">
                                <asp:Literal ID="lGoBackDesc" runat="server"></asp:Literal>
                                <asp:Literal ID="lGoBack" runat="server"></asp:Literal>
                            </div>
                        </div>
                        <div class="row">
                            <div class="large-4 medium-4 columns">
                                <div class="sub-panel">
                                    <header>
                                        <asp:Literal ID="lsupplier" runat="server"></asp:Literal>
                                        <!--   <%= Razoom.Resources.forms.Forms.supplier  %> -->
                                    </header>
                                    <section>
                                        <div class="row">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <%=Razoom.Resources.forms.Forms.attention %>
                                                </label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <asp:TextBox ID="tbAtten" runat="server" CssClass="tbAtt"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <%=Razoom.Resources.forms.Forms.address1 %>
                                                </label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <asp:TextBox ID="tbAdd1" runat="server" CssClass="tbAdd1"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <%=Razoom.Resources.forms.Forms.address2 %>
                                                </label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <asp:TextBox ID="tbAdd2" runat="server" CssClass="tbAdd2"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <%= Razoom.Resources.forms.Forms.town %>
                                                </label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <asp:TextBox ID="tbAdd3" runat="server" CssClass="tbAdd3"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <%=Razoom.Resources.forms.Forms.region %>
                                                </label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <asp:TextBox ID="tbAdd4" runat="server" CssClass="tbAdd4"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <%=Razoom.Resources.forms.Forms.postcode %>
                                                </label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <asp:TextBox ID="tbAdd5" runat="server" CssClass="tbAdd5"></asp:TextBox>
                                            </div>
                                        </div>

                                    </section>

                                </div>
                            </div>
                            <div class="large-4 medium-4 columns">
                                <div class="sub-panel">
                                    <header>
                                        <%=Razoom.Resources.forms.Forms.linkto %>
                                    </header>
                                    <section>
                                        <%--JOB--%>
                                        <asp:Panel ID="pJobSelect" runat="server" Visible="false">
                                            <div class="row">
                                                <div class="medium-4 columns">
                                                    <br>
                                                    <label class="inline">
                                                        <%=Razoom.Resources.forms.Forms.job %>
                                                    </label>
                                                </div>
                                                <div class="medium-8 columns">
                                                    <p>
                                                        <asp:Literal ID="lCross" runat="server"></asp:Literal><a href="#"><asp:Label ID="lSelected" runat="server" Text="" /></a>
                                                        <asp:HiddenField ID="hfJobID" runat="server" />
                                                    </p>
                                                    <br>
                                                    <div class="row collapse">
                                                        <div class="small-2 columns">
                                                            <span class="prefix"><i class="icon-search"></i></span>
                                                        </div>
                                                        <div class="small-10 columns">
                                                            <asp:TextBox ID="tbJob" runat="server" class="search-spinner"></asp:TextBox>
                                                            <div id="divJob" class="acList"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="pJob" runat="server" Visible="false">
                                            <div class="row">
                                                <div class="medium-4 columns">
                                                    <label class="inline">
                                                        <%=Razoom.Resources.forms.Forms.job %></label>
                                                </div>
                                                <div class="medium-8 columns">
                                                    <p>
                                                        <asp:Literal ID="lJobName" runat="server" />
                                                        <asp:LinkButton ID="lbDeleteJob" runat="server" class='pull-right button plain small'>
                                                                    <i class='icon-cross'></i>
                                                        </asp:LinkButton>
                                                    </p>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <%--STOCK--%>
                                        <asp:Panel ID="pStockSelect" runat="server" Visible="false">
                                            <div class="row">
                                                <div class="medium-4 columns">
                                                    <br>
                                                    <label class="inline">
                                                        <%=Razoom.Resources.forms.Forms.stock %>
                                                    </label>
                                                </div>
                                                <div class="medium-8 columns">
                                                    <p>
                                                        <asp:Literal ID="lCrossStck" runat="server"></asp:Literal><a href="#"><asp:Label ID="lSelectedStock" runat="server" Text="" /></a>
                                                        <asp:HiddenField ID="hfStockID" runat="server" />
                                                    </p>
                                                    <br>
                                                    <div class="row collapse">
                                                        <div class="small-2 columns">
                                                            <span class="prefix"><i class="icon-search"></i></span>
                                                        </div>
                                                        <div class="small-10 columns">
                                                            <asp:TextBox ID="tbStock" runat="server" class="search-spinner"></asp:TextBox>
                                                            <div id="divSales" class="acList"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                        <asp:Panel ID="pStock" runat="server" Visible="false">
                                            <div class="row">
                                                <div class="medium-4 columns">
                                                    <label class="inline">
                                                        <asp:Literal ID="lType" runat="server" Text="Stock" />
                                                    </label>
                                                </div>
                                                <div class="medium-8 columns">
                                                    <p>
                                                        <asp:Literal ID="lStockName" runat="server" />
                                                        <asp:LinkButton ID="lbDeleteStock" runat="server" class='pull-right button plain small'>
                                                                    <i class='icon-cross'></i>
                                                        </asp:LinkButton>
                                                    </p>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                    </section>
                                </div>
                            </div>
                            <div class="large-4 medium-4 columns">
                                <div class="sub-panel">
                                    <header>
                                        <%=Razoom.Resources.forms.Forms.details  %>
                                    </header>
                                    <section>
                                        <div class="row collapse">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <asp:Literal ID="lpurchaseno" runat="server" />
                                                    <%--<%=Razoom.Resources.forms.Forms.purchaseno  %>--%>
                                                </label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <div class="small-2 columns">
                                                    <span class="prefix"><i class="icon-lock"></i></span>
                                                </div>
                                                <div class="small-10 columns">
                                                    <asp:TextBox ID="tNumber" runat="server" Enabled="false" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <asp:Literal ID="lpurchaseref" runat="server" />
                                                    <%-- %><%=Razoom.Resources.forms.Forms.purchaseref  %>--%>
                                                </label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <asp:TextBox ID="tRef" runat="server" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <asp:Literal ID="lpurchasedate" runat="server" />
                                                    <%--<%=Razoom.Resources.forms.Forms.purchasedate  %>--%>
                                                </label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <asp:TextBox ID="tPDate" runat="server" CssClass="datepicker" required data-abide-group="purchase" />
                                                <small class="error">
                                                    <%=Razoom.Resources.validation.validation.required  %>
                                                </small>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <asp:Literal ID="lpurchaseby" runat="server" />
                                                    <%--<%=Razoom.Resources.forms.Forms.purchaseby  %>--%>
                                                </label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <asp:DropDownList ID="dUsers" runat="server" DataTextField="Email" DataValueField="UserID" CssClass="select2" AppendDataBoundItems="true" required data-abide-group="purchase" />
                                                <small class="error">
                                                    <%=Razoom.Resources.validation.validation.daterequired  %>
                                                </small>
                                            </div>
                                        </div>
                                        <div class="row" id="dVDecl" runat="server" visible="false">
                                            <div class="medium-5 columns">
                                                <label class="inline">
                                                    <%= Razoom.Resources.forms.Forms.showvehicledeclaration %></label>
                                            </div>
                                            <div class="medium-7 columns">
                                                <asp:CheckBox ID="chkVDecl" runat="server" Checked="true" />

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="medium-12 columns">
                                            </div>
                                        </div>
                                    </section>
                                </div>
                            </div>
                        </div>
                    </section>

                    <br>
                    <%-- RJS NOTE: br added to fix alignment issue with footer in FireFox --%>
                    <footer class="offset">
                        <div class="row">
                            <div class="medium-12 columns text-right">
                                <asp:Button ID="lbSavePurchase" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.save %>" CssClass="button success large pull-right loading processing" required data-abide-group="purchase" formnovalidate />
                                <asp:LinkButton ID="bAction" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.commit %>" CssClass="button success text large pull-right plain toggleShowHideClass noFade processing" target-class="processing" />
                                 <a id="liEmail" runat="server" visible="false" href="javascript:;" class="requiredNav large plain button toggleShowHide uppercase-text" target-id="emailpurch">
                                    <i class="icon-envelope"></i>
                                    <%=Razoom.Resources.forms.Forms.email %>
                                 </a>
                                <asp:HyperLink ID="hlDocument" CssClass="requiredNav large plain button uppercase-text" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.printpurchase %>" />

                                <div class="hide processing pull-right">
                                    <i class="icon-spinner icon-spin"></i>
                                </div>
                                <asp:Repeater ID="rAccountIntegration" runat="server">
                                    <ItemTemplate>
                                        <a id="aAccountIntegration" runat="server" target="_ACCOUTING" class="button large secondary plain requiredNav pull-right" />
                                    </ItemTemplate>
                                </asp:Repeater>
                                <a id="optionList" runat="server" href="javascript:;" class="button large plain text footer-menu requiredNav" data-dropdown="dropFooter">
                                    <i></i>
                                    <div class="hide-for-small"><%= Razoom.Resources.forms.Forms.options %></div>
                                </a>



                                <ul id="dropFooter" class="f-dropdown right content" data-dropdown-content>
                                  <li><asp:LinkButton ID="lbReGen" runat="server" CssClass="requiredEdit"></asp:LinkButton></li>

                                    <li id="liEdit" runat="server" visible="false">
                                        <asp:LinkButton ID="lbEdit" runat="server" CssClass="requiredEdit"></asp:LinkButton>
                                    </li>

                                    <li id="liDelete" runat="server">
                                        <a href="#deleteAnchor" class="toggleShowHide" target-id="deleteInvoice">
                                            <i class="icon-cross"></i>
                                            <%= Razoom.Resources.forms.Forms.delete %>
                                        </a>
                                    </li>                   
                                </ul>
                                <asp:Label ID="lbEditWarning" class="warning text-left " runat="server" Visible="false"></asp:Label>
                            </div>
                        </div>
                    </footer>
                </div>
            </div>
        </section>
        <section>
            <p class="title" data-section-title>
                <a id="aNoteTab" runat="server" href="#" class="eventlink">
                    <%= Razoom.Resources.forms.Forms.notes %> / <%= Razoom.Resources.forms.Forms.events %>
                </a>
            </p>
            <div class="panel-form content" data-section-content>
                <div class="row">
                    <asp:UpdatePanel ID="up1" runat="server">
                        <ContentTemplate>
                            <div class="medium-6 columns">
                                <div class="sub-panel">
                                    <header>
                                        <%= Razoom.Resources.forms.Forms.notes %>
                                    </header>
                                    <section>
                                        <raz:notes ID="rNotes" runat="server" />

                                    </section>
                                </div>

                            </div>
                            <div class="medium-6 columns">
                                <div class="sub-panel">
                                    <header>
                                        <%= Razoom.Resources.forms.Forms.events %>
                                    </header>
                                    <section>
                                        <raz:eventhistory ID="ctrEvent" runat="server" />
                                    </section>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </section>
    </div>

    <%--
        RJS NOTE:
        I have added  style="position:static;" to an element below to remove the position:relative style.
        This was causing the content to appear over the top of the Options dropdown menu 
    --%>

    <div id="emailpurch" class="row hide">
        <div class="large-12 columns" style="position: static;">
            <div class="panel-info">
                <section>
                    <div class="sub-panel">
                        <header>
                            <%=Razoom.Resources.forms.Forms.email %>
                            <small><a href="#!" class="toggleHide button plain pull-right requiredNav" target-id="emailpurch"><i class="icon-cross"></i></a></small>
                        </header>
                        <section>
                            <div class="row">
                                <div class="medium-2 columns">
                                    <label for=""><%=Razoom.Resources.forms.Forms.from %>:</label>
                                </div>
                                <div class="medium-6 columns">
                                    <p class="light">
                                        <asp:Literal ID="lemailFrom" runat="server"></asp:Literal>
                                    </p>
                                    <br>
                                </div>
                                <div class="medium-4 columns">
                                </div>
                            </div>
                            <div class="row">
                                <div class="medium-2 columns">
                                    <label for="" required><%=Razoom.Resources.forms.Forms.to %>:</label>
                                </div>
                                <div class="medium-6 columns">
                                    <asp:TextBox ID="tbemailtop" runat="server" required data-abide-group="emailtop" Type="email" CssClass="requiredNav one-line autosize" TextMode="MultiLine"></asp:TextBox>
                                    <small class="error">
                                        <%=Razoom.Resources.validation.validation.email %>
                                    </small>
                                </div>
                                <div class="medium-4 columns">
                                </div>
                            </div>
                            <div class="row">
                                <div class="medium-2 columns">
                                    <label for="">Bcc:</label>
                                </div>
                                <div class="medium-6 columns">
                                    <asp:TextBox ID="tbEmailbcc" runat="server" CssClass="requiredNav one-line autosize" TextMode="MultiLine" />
                                </div>
                                <div class="medium-4 columns">
                                </div>
                            </div>
                            <div class="row">
                                <div class="medium-2 columns">
                                    <label for=""><%=Razoom.Resources.forms.Forms.subject %>:</label>
                                </div>
                                <div class="medium-6 columns">
                                    <asp:TextBox ID="tbSubject" runat="server" CssClass="requiredNav one-line autosize" TextMode="MultiLine" />
                                </div>
                                <div class="medium-4 columns">
                                </div>
                            </div>
                            <div class="row">
                                <div class="medium-2 columns">
                                    <label for=""><%=Razoom.Resources.forms.Forms.attachment %>:</label>
                                </div>
                                <div class="medium-6 columns">
                                    <p class="light">
                                        <asp:Literal ID="lAttch" runat="server"></asp:Literal>&nbsp;<asp:Literal ID="lFileSize" runat="server" />
                                    </p>
                                    <br />
                                </div>
                                <div class="medium-4 columns">
                                </div>
                            </div>
                            <div class="row">
                                <div class="medium-2 columns">
                                    <label for=""><%=Razoom.Resources.forms.Forms.body %>:</label>
                                </div>
                                <div class="medium-6 columns">
                                    <%--<asp:TextBox ID="tbemailBody" runat="server" CssClass="requiredNav autosize" TextMode="MultiLine" />--%>
                                    <div id="dqnWrapper" runat="server" class="qnWrapper">
                                        <div class="qnTemplates hide">
                                            <asp:Repeater ID="rQNotes" runat="server">
                                                <ItemTemplate>
                                                    <td>
                                                        <asp:Literal runat="server" ID="lQnote"></asp:Literal></td>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <a href="/admin/quickNotes.aspx" class="pull-right"><i class="icon-cog"></i></a>
                                        </div>
                                        <asp:TextBox CssClass="requiredNav qnTextArea" ID="tbemailBody" runat="server" TextMode="MultiLine" />
                                    </div>
                                </div>
                                <div class="medium-4 columns">
                                </div>
                            </div>
                            <div class="row">
                                <div class="medium-2 columns">
                                    <span>&nbsp;</span>
                                </div>
                                <div class="medium-6 columns text-center center">
                                    <asp:Button ID="bEmailCust" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.send %>" CssClass="button secondary requiredNav" data-abide-group="emailtop" formnovalidate />
                                </div>
                                <div class="medium-4 columns">
                                </div>
                            </div>
                        </section>
                    </div>
                </section>
            </div>
        </div>
    </div>

    <%--
        RJS NOTE:
        I have added  style="position:static;" to an element below to remove the position:relative style.
        This was causing the content to appear over the top of the Options dropdown menu 
    --%>
    <div class="row">
        <div class="large-12 columns" style="position: static;">
            <div class="panel-data">
                <header>
                    <%=Razoom.Resources.forms.Forms.items  %>
                </header>
                <section>
                    <%--    <asp:UpdatePanel ID="upPurchaseItems" runat="server">
                        <ContentTemplate>--%>
                    <div id="divNewItm" runat="server" class="calcGroup">
                        <div class="row no-bg calcRow">
                            <div class="medium-2 columns">
                                <label class="ellipsis showtooltip">
                                    <%=Razoom.Resources.forms.Forms.product  %>
                                </label>
                                <div class="row collapse">
                                    <div class="small-3 columns">
                                        <span class="prefix radius"><i class="icon-search"></i></span>
                                    </div>
                                    <div class="small-9 columns">
                                        <asp:TextBox ID="tItem" runat="server" class="productSelect search-spinner" />
                                        <small class="error">
                                            <%=Razoom.Resources.forms.Forms.product  %>
                                        </small>
                                        <div id="divItem" class="acList"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="medium-2 columns">
                                <label class="ellipsis showtooltip">
                                    <%=Razoom.Resources.forms.Forms.description  %>
                                </label>
                                <asp:TextBox ID="tDescription" runat="server" required data-abide-group="newitem" TextMode="multiline" CssClass="one-line autosize" MaxLength="150" />
                                <asp:Label ID="lDescription" runat="server" Style="display: none;" />
                                <a id="bDescription" runat="server" class="button secondary delete small plain btn btn-danger" style="display: none;" />
                                <span id="svehicle" runat="server">
                                    <label for="">
                                        <asp:Label ID="lDesc" runat="server" /><a onclick="clearV();" class="button plain small" id="vlink"><i class="icon-cross"></i></a>
                                        <asp:HiddenField ID="hfV" runat="server" />
                                    </label>
                                </span>
                                <small class="error">
                                    <%=Razoom.Resources.validation.validation.description  %>
                                </small>
                            </div>
                            <div id="divAccountAdd" runat="server">
                                <label class="ellipsis showtooltip">
                                    <%= Razoom.Resources.forms.Forms.account  %>
                                </label>
                                <asp:DropDownList ID="dAccount" runat="server" CssClass="select2 dAcc" DataTextField="Name" DataValueField="AccountID" required />
                            </div>
                            <div class="medium-1 columns">
                                <label class="ellipsis showtooltip">
                                    <%=Razoom.Resources.forms.Forms.qty  %>
                                </label>
                                <asp:TextBox ID="tQty" runat="server" class="fCalc quantity" pattern="integer" data-abide-group="newitem" />
                                <small class="error">
                                    <%=Razoom.Resources.validation.validation.valuenumber %>
                                </small>
                            </div>
                            <div class="medium-1 columns" runat="server" id="divUnitOfMeasure" visible="<%$Code: AuthDetail.AuthLocation.Container.ContainerCountry.UnitOfMeasure %>">
                                <label class="ellipsis showtooltip">
                                    <%=Razoom.Resources.forms.Forms.unitofmeasure_abrv  %>
                                </label>
                                <asp:DropDownList ID="dUnitOfMeasure" runat="server" CssClass="select2 dUOM" />
                            </div>
                            <div class="medium-1 columns">
                                <label class="ellipsis showtooltip">
                                    <%=Razoom.Resources.forms.Forms.value  %>
                                </label>
                                <asp:TextBox ID="tvalue" runat="server" CssClass="fCalc unit" required pattern="integer" data-abide-group="newitem" />
                                <small class="error">
                                    <%=Razoom.Resources.validation.validation.valuenumber %>
                                </small>
                            </div>
                            <div class="medium-1 columns">
                                <label class="ellipsis showtooltip">
                                    <%= Razoom.Resources.forms.Forms.taxrate  %></label>
                                <raz:RazoomDropDownList ID="dTax" runat="server" Width="100%" DataTextField="Rate" DataValueField="TaxGroupID" AppendDataBoundItems="true" CssClass="fCalc vat" />
                                <small class="error">
                                    <%=Razoom.Resources.validation.validation.selectvalue %>
                                </small>
                            </div>
                            <div class="medium-1 columns">
                                <label class="ellipsis showtooltip">
                                    <%=Razoom.Resources.forms.Forms.taxtotal  %></label>
                                <asp:TextBox ID="tTax" runat="server" CssClass="fCalc tax" Enabled="false" />
                            </div>
                            <div class="medium-1 columns">
                                <label class="ellipsis showtooltip">
                                    <%=Razoom.Resources.forms.Forms.total  %></label>
                                <asp:TextBox ID="tTotal" runat="server" CssClass="fCalc subtotal" Enabled="false" />
                            </div>
                            <div class="medium-1 columns">
                                <br>
                                <asp:HiddenField ID="hfPackageID" runat="server" />
                                <asp:HiddenField ID="hfProductID" runat="server" />
                                <asp:Button ID="bAdd" runat="server" class="button add success pull-right wrap-word" Text="<%$ Code:Razoom.Resources.forms.Forms.add %>" required data-abide-group="newitem" formnovalidate />
                            </div>
                        </div>
                        <hr class="no-margin">
                        <br>
                    </div>
                    <asp:Repeater ID="rs" runat="server">
                        <ItemTemplate>
                            <div class="row lineItemWrapper">
                                <div class="medium-4 small-12 columns">
                                    <a href="#!" id="aEditItm" runat="server" class="toggleShowClass editLineItemBtn" target-class="editLineItem"><i class="icon-edit"></i></a>
                                    <asp:Literal ID="lDe" runat="server" />
                                </div>
                                <div id="divAccountItems" runat="server">
                                    <asp:Literal ID="lA" runat="server" />
                                </div>
                                <div class="small-6 show-for-small columns text-right">
                                    <small class="light"><%= Razoom.Resources.forms.Forms.unit %>:</small>
                                </div>
                                <div class="medium-1 small-2 columns text-right">
                                    <asp:Literal ID="lQ" runat="server" />
                                </div>
                                <div class="medium-1 small-2 columns text-right" runat="server" id="divUnitOfMeasureHeader" visible="<%$Code: AuthDetail.AuthLocation.Container.ContainerCountry.UnitOfMeasure %>">
                                    <asp:Literal ID="lUnitOfMeasure" runat="server" />
                                </div>
                                <div class="medium-1 small-1 columns text-right">
                                    <div class="show-for-small">x</div>
                                </div>
                                <div class="medium-1 small-3 columns text-right">
                                    <asp:Literal ID="lC" runat="server" />
                                </div>
                                <div class="small-6 show-for-small columns text-right">
                                    <small class="light"><%= Razoom.Resources.forms.Forms.taxrate %>:</small>
                                </div>
                                <div class="medium-1 small-6 columns text-right">
                                    <asp:Literal ID="lTr" runat="server" />
                                </div>
                                <div class="small-6 show-for-small columns text-right">
                                    <small class="light"><%= Razoom.Resources.forms.Forms.tax %>:</small>
                                </div>
                                <div class="medium-1 small-6 columns text-right">
                                    <asp:Literal ID="lTa" runat="server" />
                                </div>
                                <div class="small-6 show-for-small columns text-right">
                                    <small class="light"><%= Razoom.Resources.forms.Forms.total %>:</small>
                                </div>
                                <div class="medium-1 small-6 columns text-right">
                                    <asp:Literal ID="lto" runat="server" />
                                </div>
                                <div class="medium-1 columns text-right">
                                    <asp:Repeater ID="rRelatedNav" runat="server">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hlRelatedNav" runat="server" /><br />
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                            <hr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <%--UPDATE LINE--%>
                    <div id="divNewItemEdit" runat="server" class="sub-panel editLineItem hide">
                        <header style="height:36px">
                            <a href="#!" class="button plain pull-right toggleHideClass" target-class="editLineItem"><i class="icon-cross"></i></a>
                            <!-- <%= Razoom.Resources.forms.Forms.edit %> -->
                        </header>
                        <div class="row no-bg calcRow">
                            <section class="shaded" style="height: 65PX; margin-left: 5px; margin-right: 5px;">
                                <div class="row requiredNav">
                                    <asp:HiddenField ID="hiddenItemID" runat="server" />
                                    <asp:HiddenField ID="hiddenJobID" runat="server" />
                                    <asp:HiddenField ID="hiddenStockID" runat="server" />
                                    <asp:HiddenField ID="hiddenPurchaseID" runat="server" />
                                    <asp:HiddenField ID="hiddenVehicleID" runat="server" />
                                    <div class="medium-4 columns">
                                        <strong>
                                            <label class="ellipsis showtooltip">
                                                <strong>
                                                    <%=Razoom.Resources.forms.Forms.edit  %>
                                                </strong>
                                            </label>
                                        </strong>
                                        <asp:TextBox ID="tService" runat="server" />
                                    </div>
                                    <div class="medium-1 columns">
                                        <label for=""><%= Razoom.Resources.forms.Forms.account %></label>
                                        <asp:DropDownList ID="dAccEdit" runat="server" DataTextField="Name" DataValueField="AccountID" CssClass="itemAccount" Enabled="False" />
                                    </div>
                                    <div class="medium-1 columns">
                                        <label class="ellipsis showtooltip">
                                            <%=Razoom.Resources.forms.Forms.qty  %>
                                        </label>
                                        <asp:TextBox ID="tbQtyEdit" runat="server" class="fCalc quantity inline" pattern="integer" />
                                        <small class="error">
                                            <%=Razoom.Resources.validation.validation.valuenumber  %>
                                        </small>
                                    </div>
                                    <div class="medium-1 columns" style="height: 40px;">
                                        <label class="ellipsis showtooltip">
                                            <%=Razoom.Resources.forms.Forms.value  %>
                                        </label>
                                        <asp:TextBox ID="tbValEdit" runat="server" class="calculate" required pattern="integer" CssClass="fCalc unit inline" />
                                        <small class="error">
                                            <%=Razoom.Resources.validation.validation.valuenumber %>
                                        </small>
                                    </div>
                                    <%--  <div class="medium-1 columns">
                                        <label class="ellipsis showtooltip">
                                            <%=Razoom.Resources.forms.Forms.discount %>
                                        </label>
                                        <asp:TextBox ID="tDiscEdit" runat="server" class="fCalc discountPct inline" />
                                    </div>--%>
                                    <%--   <div class="medium-1 columns">
                                        <label class="ellipsis showtooltip">
                                            <%=Razoom.Resources.forms.Forms.net %>
                                        </label>
                                        <asp:TextBox ID="tNetEdit" runat="server" CssClass="fCalc net inline" Enabled="false" />
                                    </div>--%>
                                    <div class="medium-1 columns">
                                        <label class="ellipsis showtooltip">
                                            <%=Razoom.Resources.forms.Forms.taxrate  %>
                                        </label>
                                        <raz:RazoomDropDownList ID="dTaxEdit" runat="server" Width="100%" DataTextField="Rate" DataValueField="TaxGroupID" AppendDataBoundItems="true" CssClass="fCalc vat inline" Enabled="False" />
                                        <small class="error">
                                            <%=Razoom.Resources.validation.validation.selectvalue %>
                                        </small>
                                    </div>
                                    <div class="medium-1 columns">
                                        <label class="ellipsis showtooltip">
                                            <%=Razoom.Resources.forms.Forms.taxtotal  %>
                                        </label>
                                        <asp:TextBox ID="tbTaxTotalEdit" runat="server" Enabled="false" CssClass="fCalc tax inline" />
                                    </div>
                                    <div class="medium-1 columns">
                                        <label class="ellipsis showtooltip">
                                            <%=Razoom.Resources.forms.Forms.total  %>
                                        </label>
                                        <asp:TextBox ID="tbTotalEdit" runat="server" CssClass="fCalc subtotal inline" Enabled="false" />
                                    </div>
                                    <%--
                                hidden until we introduce Parts
                                <div class="medium-2 columns changePart showPart">
                                    <label for="">Related Part</label>
                                    <a href="#!" class="toggleShowHideClass noFade button plain pull-right" target-class="changePart"><i class="icon-cross are-you-sure"></i></a>
                                    <div id="linkPart"></div>
                                </div>
                                <div class="medium-2 columns changePart hide addPart clearPartID">
                                    <label for="">Related Part</label>
                                    <div class="row collapse">
                                        <div class="small-3 columns">
                                            <span class="prefix radius"><i class="icon-search"></i></span>
                                        </div>
                                        <div class="small-9 columns">
                                            <input type="text" id="input_Part" class="requiredNav" placeholder="<%= Razoom.Resources.forms.Forms.searchpurchases %>">
                                        </div>
                                    </div>
                                </div>
                                    --%>
                                    <div class="medium-2 columns">
                                        <label for="">&nbsp;</label>
                                        <footer class="offset">
                                            <div class="row">
                                                <div class="medium-10 columns" style="margin-left: 35px; margin-top: 19px">
                                                    <a id="optionsLineItem" runat="server" href="javascript:;" class="button large plain text footer-menu requiredNav no-padding-top" data-dropdown="dropFooter2">
                                                        <i></i>
                                                        <div class="hide-for-small"><%= Razoom.Resources.forms.Forms.options %></div>
                                                    </a>
                                                    <ul id="dropFooter2" class="f-dropdown right content" data-dropdown-content>
                                                        <li id="liDeletelLineItem" runat="server">
                                                            <a href="#deleteAnchor" class="toggleShowHideDeleteLI" target-id="deleteLineItem">
                                                                <i class="icon-cross"></i>
                                                                <%=Razoom.Resources.forms.Forms.delete %>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                    <a href="#editRepairLineItemAnchor" id="aRepairLineItem" class="toggleShowHideEditLI" target-id="editLineItem" runat="server" cssclass="button success confirm pull-right" data-abide-group="editLineItem">
                                                        <i class="button confirm success"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </footer>
                                    </div>
                                    <div class="large-8 medium-8 small-12 columns text-right">
                                    </div>
                                </div>

                            </section>
                        </div>
                    </div>
                    <%--UPDATE END--%>
                    <div class="row">
                        <div class="medium-2 medium-offset-8 large-offset-8 small-4 columns text-right">
                            <label>
                                <%=Razoom.Resources.forms.Forms.subtotal  %>
                            </label>
                        </div>
                        <div class="medium-1 columns small-8 text-right">
                            <asp:Literal ID="lSubT" runat="server" /><br>
                            <br>
                        </div>
                        <div class="medium-1 columns">
                        </div>
                    </div>
                    <div class="row">
                        <div class="medium-2 medium-offset-8 large-offset-8 small-4 columns text-right">
                            <label>
                                <%=Razoom.Resources.forms.Forms.taxtotal  %>
                            </label>
                        </div>
                        <div class="medium-1 columns small-8 text-right">
                            <asp:Literal ID="lTax" runat="server" /><br>
                            <br>
                        </div>
                        <div class="medium-1 columns">
                        </div>
                    </div>
                    <div class="row">
                        <div class="medium-2 medium-offset-8 large-offset-8 small-4 columns text-right">
                            <label>
                                <%=Razoom.Resources.forms.Forms.total  %>
                            </label>
                        </div>
                        <div class="medium-1 columns small-8 text-right">
                            <span class="sub-total-top grand-total">
                                <asp:Literal ID="lTot" runat="server" />
                            </span>
                            <br>
                            <br>
                        </div>
                        <div class="medium-1 columns">
                        </div>
                    </div>
                    <div class="row">
                        <div class="large-12 columns">
                        </div>
                        <br />
                        <br />
                    </div>
                    <asp:Panel ID="panelPayment" runat="server" Visible="false">
                        <!-- start payments -->
                        <div class="row">
                            <div class="large-12 columns">
                                <div class="sub-panel">
                                    <header>
                                        <%= Razoom.Resources.forms.Forms.payments %>
                                    </header>
                                    <section>
                                        <div class="row hide-for-small">
                                            <div class="medium-2 columns">
                                                &nbsp;
                                            </div>
                                            <div class="medium-2 columns">
                                                <label for=""><%= Razoom.Resources.forms.Forms.paymentdate %></label>
                                            </div>
                                            <div class="medium-2 columns">
                                                <label for=""><%= Razoom.Resources.forms.Forms.paymenttype %></label>
                                            </div>
                                            <div class="medium-3 columns">
                                                <label for=""><%= Razoom.Resources.forms.Forms.account %></label>
                                            </div>
                                            <div class="large-1 medium-1 columns">
                                                <label for=""><%= Razoom.Resources.forms.Forms.reference %></label>
                                            </div>
                                            <div class="large-1 medium-1 columns">
                                                <label for=""><%= Razoom.Resources.forms.Forms.value %></label>
                                            </div>
                                            <div class="large-1 medium-1 columns">
                                                &nbsp;
                                                <a id="aAccountIntegrationPayment" runat="server" target="_ACCOUTING" class="button large plain requiredNav pull-right hide" />
                                            </div>
                                        </div>
                                        <asp:Repeater ID="rPayment" runat="server">
                                            <ItemTemplate>
                                                <div class="row  jc-total">
                                                    <div class="medium-2 columns hide-for-small">
                                                        &nbsp;
                                                    </div>
                                                    <div class="small-6 columns show-for-small">
                                                        <small class="light"><%= Razoom.Resources.forms.Forms.paymentdate %>:</small>
                                                    </div>
                                                    <div class="medium-2 small-6 columns">
                                                        <asp:Literal ID="lPayDate" runat="server" />
                                                    </div>
                                                    <div class="small-6 columns show-for-small">
                                                        <small class="light"><%= Razoom.Resources.forms.Forms.paymenttype %>:</small>
                                                    </div>
                                                    <div class="medium-2 small-6 columns">
                                                        <asp:Literal ID="lDe" runat="server" />
                                                    </div>
                                                    <div class="small-6 columns show-for-small">
                                                        <small class="light"><%= Razoom.Resources.forms.Forms.account %>:</small>
                                                    </div>
                                                    <div class="medium-3 small-6 columns">
                                                        <asp:Literal ID="lA" runat="server" />
                                                    </div>
                                                    <div class="small-6 columns show-for-small">
                                                        <small class="light"><%= Razoom.Resources.forms.Forms.reference %>:</small>
                                                    </div>
                                                    <div class="medium-1 small-6 columns">
                                                        <asp:Literal ID="lRef" runat="server" />&nbsp;
                                                    </div>
                                                    <div class="small-6 columns show-for-small">
                                                        <small class="light"><%= Razoom.Resources.forms.Forms.value %>:</small>
                                                    </div>
                                                    <div class="medium-1 small-6 columns text-right">
                                                        <asp:Literal ID="lTotal" runat="server" />
                                                    </div>
                                                    <div class="medium-1 columns">
                                                        &nbsp;
                                                        <a id="aAccountIntegrationPayment" runat="server" target="_ACCOUTING" class="button large plain requiredNav pull-right hide" />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="medium-9 medium-offset-4 columns">
                                                        <small class="light">
                                                            <%=Razoom.Resources.forms.Forms.added  %>:
                                                            <asp:Literal ID="lAddedBy" runat="server" />
                                                            <asp:Literal ID="lAddedDate" runat="server" />
                                                        </small>
                                                    </div>
                                                </div>
                                                <hr class="show-for-small">
                                                <br>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <div class="row">
                                            <div class="medium-2 columns">
                                                &nbsp;
                                            </div>
                                            <div class="medium-2 columns">
                                                <label class="hide-for-medium-up">
                                                    <%=Razoom.Resources.forms.Forms.paymentdate  %>
                                                </label>
                                                <asp:TextBox ID="tPaymentDate" runat="server" CssClass="datepicker requiredEdit" />
                                            </div>
                                            <div class="medium-2 columns">
                                                <label class="hide-for-medium-up">
                                                    <%=Razoom.Resources.forms.Forms.paymenttype  %>
                                                </label>
                                                <asp:DropDownList ID="dPaymentType" runat="server" Width="100%" DataTextField="Name" DataValueField="PaymentTypeID" AppendDataBoundItems="true" CssClass="select2 fCalc vat requiredNav requiredEdit" required data-abide-group="payment">
                                                    <asp:ListItem Text=" --<%= Code:Razoom.Resources.forms.Forms.select%>--" Value="" />
                                                </asp:DropDownList>
                                                <small class="error">
                                                    <%=Razoom.Resources.validation.validation.selectvalue %>
                                                </small>
                                            </div>
                                            <div class="medium-3 columns">
                                                <label class="hide-for-medium-up">
                                                    <%=Razoom.Resources.forms.Forms.account  %>
                                                </label>
                                                <asp:DropDownList ID="dPaymentAccount" runat="server" Width="100%" DataTextField="Name" DataValueField="AccountID" required data-abide-group="payment" CssClass="select2 requiredNav requiredEdit" AppendDataBoundItems="true">
                                                    <asp:ListItem Text=" --<%= Code:Razoom.Resources.forms.Forms.select%>--" Value="" />
                                                </asp:DropDownList>
                                            </div>
                                            <div class="medium-1 columns">
                                                <label class="hide-for-medium-up">
                                                    <%=Razoom.Resources.forms.Forms.reference  %>
                                                </label>
                                                <asp:TextBox ID="tPaymentReference" runat="server" placeholder="<%$ Code:Razoom.Resources.forms.Forms.reference %>" CssClass="requiredEdit" />
                                            </div>
                                            <div class="medium-1 columns">
                                                <label class="hide-for-medium-up">
                                                    <%=Razoom.Resources.forms.Forms.value  %>
                                                </label>
                                                <asp:TextBox ID="tPaymentValue" runat="server" required pattern="integer" data-abide-group="payment" CssClass="requiredEdit" />
                                                <small class="error">
                                                    <%=Razoom.Resources.validation.validation.valuenumber %>
                                                </small>
                                            </div>
                                            <div class="medium-1 columns text-right">
                                                <asp:Button ID="bPayment" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.add %>" class="button add success loading requiredEdit" required data-abide-group="payment" formnovalidate />
                                                <div class="hide processing text-center">
                                                    <p><i class="icon-spinner icon-spin"></i></p>
                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                </div>
                            </div>
                        </div>
                        <br>
                        <div class="row  jc-total">
                            <div class="medium-2 medium-offset-8 small-6 columns text-right">
                                <label class="inline">
                                    <%= Razoom.Resources.forms.Forms.paymentmade %>
                                </label>
                            </div>
                            <div class="medium-1 columns small-6 text-right">
                                <strong class="sub-total-top">
                                    <asp:Literal ID="lPayMade" runat="server" />
                                </strong>
                            </div>
                            <div class="medium-1 columns">
                            </div>
                        </div>
                        <br>
                        <asp:Repeater ID="rOffset" runat="server">
                            <ItemTemplate>
                                <div class="row jc-total">
                                    <div class="medium-3 medium-offset-7 large-offset-7 small-8 columns text-right">
                                        <div class="row collapse">
                                            <div class="small-2 column">
                                                <a id="aAccountIntegrationOffset" runat="server" target="_ACCOUTING" class="button large plain requiredNav pull-right hide" />
                                            </div>
                                            <div class="small-10 column text-right">
                                                <label>
                                                    <asp:Literal ID="lDe" runat="server" />
                                                </label>
                                                <small class="light">
                                                    <%= Razoom.Resources.forms.Forms.added %>:
                                                    <asp:Literal ID="lAddedBy" runat="server" />
                                                    <asp:Literal ID="lAddedDate" runat="server" />
                                                </small>
                                            </div>
                                        </div>
                                        <hr>
                                    </div>
                                    <div class="medium-1 columns small-4 text-right">
                                        <asp:Literal ID="lTotal" runat="server" />
                                    </div>
                                    <div class="medium-1 columns">
                                        &nbsp;
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                        <!-- // payments -->
                        <div class="row jc-total">
                            <div class="medium-2 medium-offset-8 small-6 columns text-right">
                                <label class="inline">
                                    <%= Razoom.Resources.forms.Forms.paymentowed %>
                                </label>
                            </div>
                            <div class="medium-1 small-6 columns text-right">
                                <strong class="sub-total-top grand-total">
                                    <asp:Literal ID="lPaymentOwed" runat="server" />
                                </strong>
                            </div>
                            <div class="medium-1 columns">
                            </div>
                        </div>
                        <br>
                        <div class="row jc-total" id="offset" runat="server">
                            <div class="medium-3 medium-offset-7 large-offset-7 small-8 columns text-right">
                                <hr>
                                <span class="pull-left">
                                    <asp:Literal ID="warning" runat="server" /></span>
                                <label><%= Razoom.Resources.forms.Forms.offsetavailable %></label>
                            </div>
                            <div class="medium-1 columns small-4 text-right">
                                <hr>
                                <asp:HyperLink ID="hOffset" runat="server" />
                            </div>
                            <div class="medium-1 columns text-center">
                                <hr>
                                <asp:Literal ID="bOffset" runat="server"></asp:Literal>
                            </div>
                        </div>
                    </asp:Panel>
                    <br />
                    <br />
                </section>
            </div>
        </div>
    </div>
    <div id="deleteAnchor"></div>
    <div class="row hide" id="deleteInvoice">
        <div class="large-12 columns">
            <div class="panel-section">
                <header>
                    <%=Razoom.Resources.forms.Forms.deletepurchase  %>
                </header>
                <section>
                    <div class="row">
                        <div class="large-4 medium-4 small-4 columns">
                            <div class="sub-panel">
                                <header>
                                    <i class="icon-warning-sign alert"></i>
                                    <%=Razoom.Resources.forms.Forms.warning %>
                                </header>
                                <section>
                                    <p><%= Razoom.Resources.forms.Forms.deletepurchaseorcreditwarning %>:</p>
                                    <p>-<%= Razoom.Resources.forms.Forms.deletepurchase1 %>.</p>
                                    <p>-<%= Razoom.Resources.forms.Forms.deletepurchase2 %>.</p>
                                    <p>-<%= Razoom.Resources.forms.Forms.deletepurchase3 %>.</p>
                                    <p>-<%= Razoom.Resources.forms.Forms.deletepurchase4 %>.</p>
                                </section>
                            </div>
                        </div>
                        <div class="large-4 medium-4 small-4 columns">
                            <div class="sub-panel">
                                <header>
                                    <%=Razoom.Resources.forms.Forms.print %>
                                </header>
                                <section>
                                    <p><%=Razoom.Resources.forms.Forms.deletebefore %>:</p>
                                    <div class="row">
                                        <div class="large-7 columns">
                                            <label for="" class="inline"><%= Razoom.Resources.forms.Forms.print %> <%= Razoom.Resources.forms.Forms.purchase %></label>
                                        </div>
                                        <div class="large-5 columns">
                                            <asp:Literal ID="lPrint" runat="server"></asp:Literal>
                                        </div>
                                    </div>
                                    <div class="row" runat="server" id="emailDeleteAnchor" visible="false">
                                        <div class="large-3 columns">
                                            <label for="" class="inline"><%= Razoom.Resources.forms.Forms.email %></label>
                                        </div>
                                        <div class="large-6 columns">
                                            <asp:TextBox ID="tbEmail" runat="server" required data-abide-group="email" Type="email" CssClass="requiredNav"></asp:TextBox>
                                            <small class="error">
                                                <%=Razoom.Resources.validation.validation.email %>
                                            </small>
                                        </div>
                                        <div class="large-3 columns">
                                            <asp:Button ID="lbsendEmail" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.send %>" CssClass="button secondary requiredNav pull-right" data-abide-group="email" />
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                        <div class="large-4 medium-4 small-4 columns">
                            <div class="sub-panel">
                                <header>
                                    <%=Razoom.Resources.forms.Forms.confirmdelete %>
                                </header>
                                <section>
                                    <div class="row">
                                        <div class="small-10 columns">
                                            <p><%=Razoom.Resources.forms.Forms.deleteconfirm %></p>
                                        </div>
                                        <div class="small-2 columns">
                                            <label for="checkbox1" class="error">
                                                <input id="cb1" type="checkbox" name="cbDelete" required data-abide-group="deleteInvoice" class="requiredEdit" />&nbsp;*</label>
                                            <small class="error">
                                                <%=Razoom.Resources.forms.Forms.required %></small>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="large-6 columns">
                                            <a href="#" class="button cancel secondary toggleShowHide requiredEdit" target-id="deleteInvoice">
                                                <%=Razoom.Resources.forms.Forms.cancel %>
                                            </a>
                                        </div>
                                        <div class="large-6 columns">
                                            <asp:Button ID="bDelete" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.delete %>" CssClass="button delete alert pull-right requiredEdit" data-abide-group="deleteInvoice" formnovalidate />
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>

    <div id="editRepairLineItemAnchor"></div>
    <div class="row hide" id="editLineItem">
        <div class="large-12 columns">
            <div class="panel-section">
                <header>
                    <%=Razoom.Resources.forms.Forms.editlineitem  %>
                </header>
                <section>
                    <div class="row">
                        <div class="large-12 medium-12 small-12 columns">
                            <div class="sub-panel">
                                <header>
                                    <%=Razoom.Resources.forms.Forms.confirmedit %>
                                </header>
                                <section>
                                    <div class="row">
                                        <div class="large-11 medium-11 small-10 columns">
                                            <p id="pEditLineItemXeroConfirm" runat="server" visible="false"><%=Razoom.Resources.forms.Forms.editlineitemconfirmxero %> </p>
                                            <p id="pEditLineItemWithStock" runat="server" visible="false"><%=Razoom.Resources.forms.Forms.editlineitemwithstock %> </p>
                                              <p id="pEditLineItem" runat="server" visible="false"><%=Razoom.Resources.forms.Forms.editlineitemwithoutstock %> </p>
                                            <p>&nbsp;</p>
                                        </div>
                                        <div class="large-1 medium-1 small-2 columns">
                                            <label for="lblEditLineItem" class="error pull-right">
                                                <input id="cbEditLineItem" type="checkbox" name="cbEdit" required data-abide-group="editLineItem" class="requiredEdit" />&nbsp;*</label>
                                            <small class="error">
                                                <%=Razoom.Resources.forms.Forms.required %>
                                            </small>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="large-11 medium-11 small-6 columns">
                                            <a href="#" class="button cancel secondary toggleShowHide requiredEdit" target-id="editLineItem">
                                                <%=Razoom.Resources.forms.Forms.cancel %>
                                            </a>
                                        </div>
                                        <div class="large-1 medium-1 small-6 columns">
                                            <asp:Button ID="btnEditLineItem" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.edit %>" CssClass="button delete alert pull-right requiredEdit" data-abide-group="editLineItem" formnovalidate />
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
    <input type="hidden" class="mxp" id="hfPage" value="Purchase: Add/Edit Viewed">
     <div class="row hide" id="deleteLineItem">
        <div class="large-12 columns">
            <div class="panel-section">
                <header>
                    <%=Razoom.Resources.forms.Forms.deletelineitem  %>
                </header>
                <section>
                    <div class="row">
                        <div class="large-12 medium-12 small-12 columns">
                            <div class="sub-panel">
                                <header>
                                    <%=Razoom.Resources.forms.Forms.confirmdelete %>
                                </header>
                                <section>
                                    <div class="row">
                                        <div class="large-11 medium-11 small-10 columns">
                                            <p id="pDeleteLineItemXeroConfirm" runat="server" visible="False"><%=Razoom.Resources.forms.Forms.deleteLIconfirmxero %> </p>
                                            <p id="pDeleteConfirmLineItem" runat="server"><%=Razoom.Resources.forms.Forms.deleteconfirmLineItem %> </p>
                                            <p id="pDeleteLineItemStockConfirm" runat="server" visible="False"><%=Razoom.Resources.forms.Forms.deleteLIconfirmstock %> </p>
                                            <p>&nbsp;</p>
                                        </div>
                                        <div class="large-1 medium-1 small-2 columns">
                                            <label for="checkbox1" class="error pull-right">
                                                <input id="cb2" type="checkbox" name="cbDelete" required data-abide-group="deleteLineItem" class="requiredEdit" />&nbsp;*</label>
                                            <small class="error">
                                                <%=Razoom.Resources.forms.Forms.required %>
                                            </small>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="large-11 medium-11 small-6 columns">
                                            <a href="#" class="button cancel secondary toggleShowHide requiredEdit requiredNav" target-id="deleteLineItem">
                                                <%=Razoom.Resources.forms.Forms.cancel %>
                                            </a>
                                        </div>
                                        <div class="large-1 medium-1 small-6 columns">
                                            <asp:Button ID="btnDeleteLineItem" runat="server" Text="<%$ Code:Razoom.Resources.forms.Forms.delete %>" CssClass="button delete alert pull-right requiredEdit" data-abide-group="deleteLineItem" formnovalidate />
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="c3" ContentPlaceHolderID="cpFoot" runat="server">
    <script type="text/javascript">

        // Show "Update" link after closing modal 
        $('.close-full-modal').click(function () {
            $('.update-details').fadeIn(1000).fadeOut(1000).fadeIn(1000).fadeOut(1000).fadeIn(1000);
        });

        function selectContactCallback(event, ui) {
            $("#cp_tCust").val(ui.item.label);
            $("#cp_hfContactID").val(ui.item.ContactID);
            $(".tbAtt").val(ui.item.bAtt);
            $(".tbAdd1").val(ui.item.bA1);
            $(".tbAdd2").val(ui.item.bA2);
            $(".tbAdd3").val(ui.item.bA3);
            $(".tbAdd4").val(ui.item.bA4);
            $(".tbAdd5").val(ui.item.bPC);
            //$('#cp_lContact').text(ui.item.cTitle + ' ' + ui.item.fN + ' ' + ui.item.lN);
            var title = ui.item.cTitle != "" && ui.item.cTitle != null ? ui.item.cTitle : "";
            var edit = '<span>' + title + ' ' + ui.item.label + '</span><a href="#" data-reveal-id="generic-modal" onclick="setGenericModal(\'Contact\',\'&contactID=' + ui.item.ContactID + '\')">&nbsp;<i class="icon-edit"></i></a>';
            $("#cp_lContact").text(" ");
            $("#cp_lContact").append($(edit));
        }

        function selectJobCallback(event, ui) {
            var t = ui.item.Number;
            $("#cp_lSelected").text(t);
            $("#cp_lSelected").append($(' <a href="#" onclick="clearJob()" > <i class="icon-cross"></i></a>'));
            $("#cp_hfJobID").val(ui.item.ID);
        }

        function selectStockCallback(event, ui) {
            var t = ui.item.Number + " " + ui.item.Reg;
            $("#cp_lSelectedStock").text(t);
            $("#cp_lSelectedStock").append($(' <a href="#" onclick="clearStock()" > <i class="icon-cross"></i></a>'));
            $("#cp_hfStockID").val(ui.item.ID);
        }

        function clearJob() {
            $("#cp_lSelected").text('');
            $("#cp_hfJobID").val('');
        }

        function clearStock() {
            $("#cp_lSelectedStock").text('');
            $("#cp_hfStockID").val('');
        }

        $(function () {

            initAC();

            if ($('#cp_tvalue').val() != "") {
                Calculations();
                $('#cp_tvalue').trigger('change');
            };

            Calculations();
            autoCompleteContact('#cp_tSup', false, selectContactCallback, null, null, 'divSupplier');
            autoCompleteProduct('#cp_tItem', false, selectProductSale, focusProductSale, mapProductPurchase, null, 'divItem');
            autoCompleteProduct('#cp_tItemEdit', false, selectProductSale, focusProductSale, mapProductSale, null, 'divItemEdit');
            $('#cp_tDescription').attr("MaxLength", "150");
            if ($('#cp_tbStock').length > 0)
                autoCompleteStock('#cp_tbStock', false, selectStockCallback, null, 'divSales');

            if ($('#cp_tbJob').length > 0)
                autoCompleteJob('#cp_tbJob', false, selectJobCallback, null, 'divJob');

            if ($('#input_Job').length > 0)
                autoCompleteJob('#input_Job', false, selectJobEditCallback, null, 'divJob');

            if ($('#input_Stock').length > 0)
                autoCompleteStock('#input_Stock', false, selectStockEditCallback, null, 'divSales');

            $('#cp_tDescription').attr("MaxLength", "150");

            $("#cp_hiddenItemID").prop("disabled", false);
            $("#cp_hiddenStockID").prop("disabled", false);
            $("#cp_hiddenJobID").prop("disabled", false);
            $("#cp_hiddenVehicleID").prop("disabled", false);
            $('#cp_tDescriptionEdit').attr("MaxLength", "150");
        });

        function renderContact(Contact) {
            $("#cp_tCust").val(Contact[0].label);
            $("#cp_hfContactID").val(Contact[0].ContactID);
            $(".tbAtt1").val(Contact[0].bAtt);
            $(".tbAdd1").val(Contact[0].bA1);
            $(".tbAdd2").val(Contact[0].bA2);
            $(".tbAdd3").val(Contact[0].bA3);
            $(".tbAdd4").val(Contact[0].bA4);
            $(".tbAdd5").val(Contact[0].bPC);
            //model popup                  
            var edit = '<span>' + Contact[0].cTitle + ' ' + Contact[0].label + '</span><a href="#" data-reveal-id="generic-modal" onclick="setGenericModal(\'Contact\',\'&contactid=' + Contact[0].ContactID + '\')">&nbsp;<i class="icon-edit"></i></a>';
            $("#cp_lContact").text(" ");
            $("#cp_lContact").append($(edit));
        }

        function pullContact() {
            if ($("#cp_hfContactID").val() != "") {
                var cID = $("#cp_hfContactID").val()
                RazoomCoreEntities.Contacts.filter(function (con) { con.ContactID == ContactID }, { ContactID: cID }).map(mapContactwithVehicleCallBack).toArray(renderContact);
            }

            __doPostBack('cp_up1', '');

        }

        //---SELECT NEW STOCK RECORD TO LINK
        function selectStockEditCallback(event, ui) {
            $("#cp_hiddenStockID").val(ui.item.ID);
            $("#linkStock").html("<a href='../sales/edit.aspx?s=" + ui.item.ID + "'>" + ui.item.Number + "</a>");
            $(".showStock").show();
            $(".addStock").hide();
            $("#cp_lVehc").html('<%= Razoom.Resources.forms.Forms.vehicle %>' + ": " + ui.item.Reg);
            $('#attchVeh').attr("vehicle-id", ui.item.vID);
        }
        //---SELECT NEW JOB RECORD TO LINK
        function selectJobEditCallback(event, ui) {
            $("#cp_hiddenJobID").val(ui.item.ID);
            $("#linkJob").html("<a href='../workshop/edit.aspx?j=" + ui.item.ID + "'>" + ui.item.Number + "</a>");
            $(".showJob").show();
            $(".addJob").hide();
        }

        $('#attchVeh').click(function () {
            var chkd = $(':checkbox:checked').length;
            if (chkd > 0)
                $("#cp_hiddenVehicleID").val($(this).attr("vehicle-id"));
            else
                $("#cp_hiddenVehicleID").val('');
        });

        function clearV() {
            $('#cp_hfV').val('');
            $('#cp_lDesc').text('');
            $('#vlink').hide();
            $('#cp_lDescEdit').text('');
            $('#vLinkEdit').hide();
            $('#cp_hfEditDesc').val('');
            $('#cp_hfVehEdit').val('');
        }

        // Update Line Items
        $(".editLineItemBtn").click(function () {
            $(".editLineItem").insertAfter($(this).closest(".lineItemWrapper"));

            var strItemID = $(this).attr("item-id");
            $("#cp_hiddenItemID").val(strItemID);

            var editItemUnPaid = $('#cp_spanUnPaid').is(":visible");

            if (editItemUnPaid) {
                $("#cp_tService").prop('readonly', false);
                $("#cp_tService").removeClass("readonly")

                $("#cp_tbQtyEdit").prop("readonly", false);
                $("#cp_tbQtyEdit").removeClass("readonly");

                $("#cp_tbValEdit").prop("readonly", false);
                $("#cp_tbValEdit").removeClass("readonly");

                $("#cp_tDiscEdit").prop("readonly", false);
                $("#cp_tDiscEdit").removeClass("readonly");

                $("#cp_dAccEdit").removeAttr("disabled");
                $("#cp_dTaxEdit").removeAttr("disabled");
                $('#cp_aRepairLineItem>i').removeAttr('disabled');
            }

            var editItemPaid = $('#cp_spanPaid').is(":visible");

            if (editItemPaid) {
                $("#cp_aRepairLineItem").remove();
            }

            var editItemPartPaid = $('#cp_spanPartPaid').is(":visible");

            if (editItemPartPaid) {
                $("#cp_aRepairLineItem").remove();
            }

            if (!editItemUnPaid & !editItemPaid & !editItemPartPaid) {
                $("#cp_dAccEdit").removeAttr("disabled");
                $("#cp_dTaxEdit").removeAttr("disabled");
            }

            $('#cp_tService').val($(this).attr("serviceEdit"));
            $('#cp_tbValEdit').val(parseFloat($(this).attr("valEdit")).toFixed(2));
            $('#cp_tbQtyEdit').val(parseFloat($(this).attr("qtyEdit")).toFixed(2));
            $('#cp_tDiscEdit').val(parseFloat($(this).attr("discEdit")).toFixed(2));

            $('#cp_tbTaxTotalEdit').val($(this).attr("taxTotalEdit"));
            $('#cp_tbTotalEdit').val($(this).attr("totalEdit"));

            var strJobNo = $(this).attr("job-no");
            var strJobID = $(this).attr("job-id");
            $("#cp_hiddenJobID").val(strJobID);
            $("#linkJob").html("<a href='../workshop/edit.aspx?j=" + strJobID + "'>" + strJobNo + "</a>");

            var strStockNo = $(this).attr("stock-no");
            var strStockID = $(this).attr("stock-id");
            var strVehicleReg = $(this).attr("vehicle-reg");
            var strVehicleID = $(this).attr("vehicle-id");

            $("#cp_hiddenStockID").val(strStockID);
            $("#linkStock").html("<a href='../sales/edit.aspx?S=" + strStockID + "'>" + strStockNo + "</a>");
            $('#attchVeh').attr("vehicle-id", strVehicleID);

            if ($(this).attr("vehicle-checked") != undefined)
                $('#attchVeh').attr("checked", true); // set to true if the vehicle is linked to the item, not just the stock record.            

            $("#cp_lVehc").html('<%= Razoom.Resources.forms.Forms.vehicle %>' + ": " + strVehicleReg);

            var strPartNo = $(this).attr("part-no");
            strPartID = $(this).attr("part-id");
            $("#cp_hiddenPartID").val(strPartID);
            $("#linkPart").html("<a href='../sales/edit.aspx?j=" + strPartID + "'>" + strPartNo + "</a>");


            if (strJobID == "" || strJobID == undefined) {
                $(".addJob").show();
                $(".showJob").hide();
            } else {
                $(".addJob").hide();
                $(".showJob").show();
            }

            if (strStockID == "" || strStockID == undefined) {
                $(".addStock").show();
                $(".showStock").hide();
            } else {
                $(".addStock").hide();
                $(".showStock").show();
            }

            if (strPartID == "" || strPartID == undefined) {
                $(".addPart").show();
                $(".showPart").hide();
            } else {
                $(".addPart").hide();
                $(".showPart").show();
            }

            // for select 2
            $(".itemAccount").val($(this).attr('account-id')).trigger("change");
            //for standard drop downs
            $('.itemAccount').val($(this).attr('account-id'));
        });

        // clear ids when you press "x"
        $(".clearJobID").click(function () {
            $("#cp_hiddenJobID").val("");
        });

        $(".clearStockID").click(function () {
            $("#cp_hiddenStockID").val("");
        });

        $(".clearPartID").click(function () {
            $("#cp_hiddenPartID").val("");
        });

        $(".toggleShowHideEditLI").click(function () {
            $('#editLineItem').show();
        });


        $(".hideWarningMsg").click(function () {
            $('#editLineItem').hide();

            $('#deleteLineItem').hide();
        });
 $(".toggleShowHideDeleteLI").click(function () {
            $('#deleteLineItem').show();
        });
    </script>
</asp:Content>
