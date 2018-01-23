Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Xml

Namespace CaptchaBlogComment
	Partial Public Class _Default
		Inherits System.Web.UI.Page
		Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		End Sub

		Protected Function ConvertToDate(ByVal objDate As Object) As DateTime
			Dim result As DateTime = DateTime.MinValue
			If Not(objDate IsNot Nothing AndAlso DateTime.TryParse(objDate.ToString().TrimEnd(New Char() { " "c, "P"c, "S"c, "T"c }), result)) Then
				Return DateTime.Now
			End If
			Return result
		End Function

		Protected Sub ClearEditors()
			tbName.Text = String.Empty
			taComment.InnerText = String.Empty
		End Sub

		Protected Sub btnAddComment_Click(ByVal sender As Object, ByVal e As EventArgs)
			If (Not Captcha.IsValid) Then
				Return
			End If

			Dim guestBook As New XmlDocument()
			guestBook.Load(Server.MapPath("~/App_Data/GuestBook.xml"))
			Dim commentNode As XmlElement = guestBook.CreateElement("comment")
			Dim authorNameNode As XmlElement = guestBook.CreateElement("authorName")
			Dim postTimeNode As XmlElement = guestBook.CreateElement("postTime")
			Dim bodyNode As XmlElement = guestBook.CreateElement("body")
			authorNameNode.AppendChild(guestBook.CreateTextNode(tbName.Text))
			postTimeNode.AppendChild(guestBook.CreateTextNode(DateTime.Now.ToString()))
			bodyNode.AppendChild(guestBook.CreateTextNode(taComment.InnerText))
			commentNode.AppendChild(authorNameNode)
			commentNode.AppendChild(postTimeNode)
			commentNode.AppendChild(bodyNode)
			guestBook.DocumentElement.PrependChild(commentNode)

			' Uncomment the line below to save comments
			' guestBook.Save(Server.MapPath("~/App_Data/GuestBook.xml"));

			ClearEditors()
		End Sub
	End Class
End Namespace