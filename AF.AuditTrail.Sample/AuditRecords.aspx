<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AuditRecords.aspx.cs" Inherits="AF.AuditTrail.Sample.AuditRecords" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:GridView ID="grdAudit" runat="server" AutoGenerateColumns="false" OnPageIndexChanging="Audit_PageIndexChanging"
        DataKeyNames="AuditID" Width="100%" OnRowCommand="grdAudit_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="AuditID" Visible="false">
                <ItemTemplate>
                    <asp:Label ID="AuditID" Text='<%#Eval("AuditID") %>' runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="RecordID">
                <ItemTemplate>
                    <asp:Label ID="RecordID" Text='<%#Eval("RecordID") %>' runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ParentRecordID">
                <ItemTemplate>
                    <asp:Label ID="ParentRecordID" Text='<%#Eval("ParentRecordID") %>' runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ModuleID">
                <ItemTemplate>
                    <asp:Label ID="ModuleID" Text='<%#Eval("ModuleID") %>' runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="DataTypeID">
                <ItemTemplate>
                    <asp:Label ID="DataTypeID" Text='<%#Eval("DataTypeID") %>' runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ChangeType">
                <ItemTemplate>
                    <asp:Label ID="ChangeType" Text='<%#Eval("ChangeType") %>' runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="ModifiedOn">
                <ItemTemplate>
                    <asp:Label ID="ModifiedOn" Text='<%#Eval("ModifiedOn") %>' runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="btnShow" runat="server" CommandName="Show" ImageUrl="~/Images/Detail.png"
                        AlternateText="Show" CommandArgument='<%#Eval("AuditID") %>'
                        Height="16px" Width="16px" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br /><br />
    <asp:GridView ID="grdAuditDetail" runat="server" AutoGenerateColumns="true" Width="100%">
    </asp:GridView>
</asp:Content>
