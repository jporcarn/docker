<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="web_app._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>ASP.NET - VB6 - Docker</h1>
        <p></p>
    </div>

    <div class="row">
        <div class="col-md-12">
            <h2>Getting started</h2>
            <p>
                Click the button below to retrieve customer's records in AdventureWorksLT2019 sample database using a VB6 (COM) library registered within a Docker container
            </p>
            <p>
                <asp:LinkButton ID="CustomersButton" Text="Customers" runat="server" CssClass="btn btn-default" OnClick="CustomersButton_Click" />
            </p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging">
                <Columns>
                    <asp:BoundField DataField="CustomerId" HeaderText="CustomerId" SortExpression="CustomerId" />
                    <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                    <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"></asp:ObjectDataSource>
        </div>
    </div>
    <div class="row text-danger">
        <div class="col-md-12">
            <asp:Label ID="ErrorLabel" runat="server" Text=""></asp:Label>
        </div>
    </div>
</asp:Content>