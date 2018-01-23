<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="CaptchaBlogComment._Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxEditors.v10.1, Version=10.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v10.1, Version=10.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxHeadline" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <style type="text/css">
        html, body {
           color:#303440;
           font-family:Tahoma,Arial,Verdana;
           font-size:small;
        }
        
        .CommentsTitle {
            color:#576FA5;
            font-size:170%;
            font-weight:lighter;
            margin:0 0 16px;
            padding:0;
        }
        
        .CommentsDiv {
            border-color:#EEEEEE;
            border-style:solid;
            border-width:1px 0 1px;
            padding:12px 8px 8px;
        }
        
        .FormTitle {
           color:#AAAAAA;
           font-size:130%;
           font-weight:bold;
           letter-spacing:-1px;
           margin:0 0 16px;
           padding:0;
        }
        
        
        .FormArea {
           margin:16px 0;
        }
       
        .FormFieldName {
            font-weight:bold;
            padding:8px 2px 2px;
        }
        
        .FormField {
            padding:2px;
        }
        
        .FormCommentTextArea {
            background-color:White;
            border:1px solid #AECAF0;
            font-family:Tahoma;
            font-size:100%;
        }
    </style>

    <script type="text/javascript">
        function OnTextAreaFocus() {
            var textArea = document.getElementById("taComment");
            textArea.style.borderColor = "#6E90BE";
        }

        function OnTextAreaBlur() {
            var textArea = document.getElementById("taComment");
            textArea.style.borderColor = "#AECAF0";
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="CommentsDiv">
            <h4 class="CommentsTitle">
                Recent comments</h4>
            <asp:Repeater ID="rptrComments" runat="server" DataSourceID="GuestBookDataSource"
                EnableViewState="False">
                <ItemTemplate>
                    <dx:ASPxHeadline EncodeHtml="False" ID="hdlComments" EnableViewState="False" runat="server"
                        ContentText='<%# XPath("body") %>' Date='<%# ConvertToDate(XPath("postTime")) %>'
                        HeaderText='<%# XPath("authorName") %>' DateVerticalPosition="Header" TailPosition="KeepWithLastWord"
                        DateFormatString="{0:g}">
                        <LeftPanelStyle Spacing="25px">
                        </LeftPanelStyle>
                        <RightPanelStyle Spacing="25px">
                        </RightPanelStyle>
                        <DateStyle Spacing="5px">
                        </DateStyle>
                        <HeaderStyle Spacing="7px" />
                    </dx:ASPxHeadline>
                    <br />
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div style="padding-top: 30px;">
            <h4 class="FormTitle">
                Leave a comment</h4>
            <div class="FormFieldName">
                <dx:ASPxLabel ID="lblName" runat="server" Text="Name">
                </dx:ASPxLabel>
            </div>
            <div class="FormField">
                <dx:ASPxTextBox ID="tbName" runat="server" Size="60">
                    <ValidationSettings ErrorTextPosition="Bottom">
                        <ErrorFrameStyle ImageSpacing="4px">
                            <ErrorTextPaddings PaddingLeft="4px" />
                        </ErrorFrameStyle>
                        <RequiredField IsRequired="true" ErrorText="This field is required" />
                    </ValidationSettings>
                </dx:ASPxTextBox>
            </div>
            <div class="FormFieldName">
                <dx:ASPxLabel ID="lblComment" runat="server" Text="Comment">
                </dx:ASPxLabel>
            </div>
            <div class="FormField">
                <textarea id="taComment" runat="server" class="FormCommentTextArea" cols="60" rows="8"
                    onfocus="OnTextAreaFocus();" onblur="OnTextAreaBlur();"></textarea>
            </div>
            <div class="FormFieldName">
                <dx:ASPxLabel ID="lblCaptcha" runat="server" Text="Verification Code">
                </dx:ASPxLabel>
            </div>
            <div class="FormField">
                <dx:ASPxCaptcha ID="Captcha" runat="server">
                    <ChallengeImage ForegroundColor="#426798" BackgroundColor="#F2F8FF" BorderColor="#AECAF0"
                        BorderWidth="1">
                    </ChallengeImage>
                </dx:ASPxCaptcha>
            </div>
            <div class="FormFieldName">
                <dx:ASPxButton ID="btnAddComment" runat="server" Text="Add comment" OnClick="btnAddComment_Click">
                </dx:ASPxButton>
                <br />
                <a href="Default.aspx">Refresh Page</a>
            </div>
            <asp:XmlDataSource ID="GuestBookDataSource" runat="server" XPath="comments/comment"
                DataFile="~/App_Data/GuestBook.xml"></asp:XmlDataSource>
        </div>
    </form>
</body>
</html>
