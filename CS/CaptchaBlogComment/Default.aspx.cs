using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace CaptchaBlogComment
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected DateTime ConvertToDate(object objDate)
        {
            DateTime result = DateTime.MinValue;
            if (!(objDate != null && DateTime.TryParse(objDate.ToString().TrimEnd(new char[] { ' ', 'P', 'S', 'T' }), out result)))
                return DateTime.Now;
            return result;
        }

        protected void ClearEditors()
        {
            tbName.Text = string.Empty;
            taComment.InnerText = string.Empty;
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            if (!Captcha.IsValid)
                return;

            XmlDocument guestBook = new XmlDocument();
            guestBook.Load(Server.MapPath("~/App_Data/GuestBook.xml"));
            XmlElement commentNode = guestBook.CreateElement("comment");
            XmlElement authorNameNode = guestBook.CreateElement("authorName");
            XmlElement postTimeNode = guestBook.CreateElement("postTime");
            XmlElement bodyNode = guestBook.CreateElement("body");
            authorNameNode.AppendChild(guestBook.CreateTextNode(tbName.Text));
            postTimeNode.AppendChild(guestBook.CreateTextNode(DateTime.Now.ToString()));
            bodyNode.AppendChild(guestBook.CreateTextNode(taComment.InnerText));
            commentNode.AppendChild(authorNameNode);
            commentNode.AppendChild(postTimeNode);
            commentNode.AppendChild(bodyNode);
            guestBook.DocumentElement.PrependChild(commentNode);

            // Uncomment the line below to save comments
            // guestBook.Save(Server.MapPath("~/App_Data/GuestBook.xml"));

            ClearEditors(); 
        }
    }
}