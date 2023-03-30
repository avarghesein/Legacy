VERSION 5.00
Object = "{0ECD9B60-23AA-11D0-B351-00A0C9055D8E}#6.0#0"; "mshflxgd.ocx"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomct2.ocx"
Begin VB.Form personform 
   Caption         =   "PERSONNEL EXPLORING"
   ClientHeight    =   6585
   ClientLeft      =   810
   ClientTop       =   1425
   ClientWidth     =   10440
   Icon            =   "personform.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6585
   ScaleWidth      =   10440
   Begin VB.Frame fsearch 
      Caption         =   "CHARACTERS FOR SEARCHING"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   6120
      TabIndex        =   21
      Top             =   1680
      Width           =   2895
      Begin VB.TextBox tsearch 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   120
         TabIndex        =   22
         Top             =   240
         Width           =   2655
      End
   End
   Begin VB.Frame fpage 
      Caption         =   "DATE OF BIRTH"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   4440
      TabIndex        =   13
      Top             =   360
      Width           =   2415
      Begin MSComCtl2.DTPicker tpage 
         Height          =   375
         Left            =   360
         TabIndex        =   14
         Top             =   240
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   661
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   21037057
         CurrentDate     =   37987.3958333333
      End
      Begin VB.Label lage 
         Alignment       =   1  'Right Justify
         Caption         =   " "
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   360
         TabIndex        =   12
         Top             =   720
         Width           =   1695
      End
   End
   Begin VB.Frame fpersonid 
      Caption         =   "PERSON-ID "
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   4440
      TabIndex        =   18
      Top             =   1560
      Width           =   1215
      Begin VB.Label lpersonid 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   8.25
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         TabIndex        =   17
         Top             =   240
         Width           =   855
      End
   End
   Begin VB.Frame fperson 
      Caption         =   "PERSON DATABASE"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3375
      Left            =   4440
      TabIndex        =   19
      Top             =   2520
      Width           =   5655
      Begin MSHierarchicalFlexGridLib.MSHFlexGrid personflex 
         Height          =   3015
         Left            =   165
         TabIndex        =   20
         Top             =   240
         Width           =   5415
         _ExtentX        =   9551
         _ExtentY        =   5318
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Book Antiqua"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         _NumberOfBands  =   1
         _Band(0).Cols   =   2
      End
   End
   Begin VB.Frame fpremarks 
      Caption         =   "REMARKS"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   330
      TabIndex        =   10
      Top             =   5445
      Width           =   3975
      Begin VB.TextBox tpremarks 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   120
         MaxLength       =   195
         MultiLine       =   -1  'True
         TabIndex        =   11
         Top             =   240
         Width           =   3735
      End
   End
   Begin VB.Frame fpqualification 
      Caption         =   "QUALIFICATION"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   330
      TabIndex        =   8
      Top             =   4605
      Width           =   3975
      Begin VB.TextBox tpqualification 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   150
         MaxLength       =   95
         TabIndex        =   9
         Top             =   240
         Width           =   3735
      End
   End
   Begin VB.Frame fpfield 
      Caption         =   "FIELD INTERESTED"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   330
      TabIndex        =   6
      Top             =   3765
      Width           =   3975
      Begin VB.ComboBox cpfield 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   240
         Width           =   3735
      End
   End
   Begin VB.Frame fpinstitution 
      Caption         =   "WORKING INSTITUTION"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   330
      TabIndex        =   4
      Top             =   2565
      Width           =   3975
      Begin VB.TextBox tpinstitution 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   735
         Left            =   120
         MaxLength       =   150
         MultiLine       =   -1  'True
         TabIndex        =   5
         Top             =   240
         Width           =   3735
      End
   End
   Begin VB.Frame fpsex 
      Caption         =   "SEX"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   6960
      TabIndex        =   15
      Top             =   600
      Width           =   1215
      Begin VB.ComboBox csex 
         BeginProperty Font 
            Name            =   "Bookman Old Style"
            Size            =   9
            Charset         =   0
            Weight          =   600
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   120
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame fpaddress 
      Caption         =   "ADDRESS"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   330
      TabIndex        =   2
      Top             =   1125
      Width           =   3975
      Begin VB.TextBox tpaddress 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   150
         MaxLength       =   200
         MultiLine       =   -1  'True
         TabIndex        =   3
         Top             =   270
         Width           =   3735
      End
   End
   Begin VB.Frame fpname 
      Caption         =   "NAME OF THE PERSON"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   330
      TabIndex        =   0
      Top             =   285
      Width           =   3975
      Begin VB.TextBox tpname 
         BeginProperty Font 
            Name            =   "Book Antiqua"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   120
         MaxLength       =   30
         TabIndex        =   1
         Top             =   240
         Width           =   3735
      End
   End
   Begin VB.Menu addnew 
      Caption         =   "ADD"
      Begin VB.Menu savenew 
         Caption         =   "SAVE-NEW"
      End
      Begin VB.Menu clearnew 
         Caption         =   "CLEAR"
      End
      Begin VB.Menu exitnew 
         Caption         =   "EXIT_NEW"
      End
   End
   Begin VB.Menu edit 
      Caption         =   "EDIT"
      Begin VB.Menu saveedit 
         Caption         =   "SAVE-EDITED"
      End
      Begin VB.Menu clearedit 
         Caption         =   "CLEAR"
      End
      Begin VB.Menu exitedit 
         Caption         =   "EXIT-EDIT"
      End
   End
   Begin VB.Menu deletes 
      Caption         =   "DELETE"
      Begin VB.Menu delperson 
         Caption         =   "DELETE-PERSON"
      End
      Begin VB.Menu delclear 
         Caption         =   "CLEAR"
      End
      Begin VB.Menu exitdel 
         Caption         =   "EXIT-DELETION"
      End
   End
   Begin VB.Menu viewmenu 
      Caption         =   "VIEW"
      Begin VB.Menu personnamelike 
         Caption         =   "PERSONS-WITH-NAME-LIKE"
      End
      Begin VB.Menu view 
         Caption         =   "VIEW-EXIT"
      End
   End
   Begin VB.Menu selection 
      Caption         =   "SELECTION"
      Begin VB.Menu selectcurrent 
         Caption         =   "SELECT-CURRENT-PERSON"
      End
      Begin VB.Menu selectexit 
         Caption         =   "EXIT-SELECTION"
      End
   End
End
Attribute VB_Name = "personform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Dim search_flg As Boolean
Public selected_name As String
Public selected_code As Long
Public owner As String
Public person_chois As String


Private Sub clearedit_Click()
  Call clearnew_Click
End Sub

Private Sub clearnew_Click()
Dim I As Integer

For I = 0 To Me.Count - 1
    If TypeOf Me.Controls(I) Is TextBox Then
          Me.Controls(I).Text = ""
    Else
        If TypeOf Me.Controls(I) Is ComboBox Then
            Me.Controls(I).ListIndex = 0
        
        End If
    End If
Next I
lpersonid.Caption = ""

End Sub

Private Sub cpfield_Click()
    If CHECK_COMBOBOX(cpfield, tpqualification) = False Then
        MsgBox "NO SELECTION IS MADE", vbOKOnly, "SELECTION ERROR"
    End If
    
End Sub

Private Sub csex_Click()
    If CHECK_COMBOBOX(cpfield, cpfield) = False Then
        MsgBox "NO SELECTION IS MADE", vbOKOnly, "SELECTION ERROR"
    End If
End Sub

Private Sub delclear_Click()
  Call clearnew_Click
End Sub

Private Sub delperson_Click()
On Error GoTo cancel
Dim tmp As String
Dim Y As New Recordset
Dim personid As Long
Dim X As New Connection

    If Not all_valid Then
       MsgBox "ERROR IN INFORMATION GOING TO BE DELETED", vbCritical, "ERROR IN DETAILS!!!"
       Exit Sub
    Else
        personid = Val(lpersonid.Caption)
        tmp = "select projid from projects where (projmanager=" & personid _
        & " and completed='F' and deleted='F')"
        Set X = dn.cn
        If X.State = 0 Then X.Open
        Set Y = X.Execute(tmp)
        If Y.RecordCount > 0 Then
            MsgBox "CAN'T DELETE THE PERSON HE IS WORKING ON," & vbCrLf _
            & "ONE OR MORE ACTIVE PROJECTS", vbOKOnly, "ERROR IN DELETION"
            Exit Sub
        End If
        Y.Close
        Set Y = X.Execute("select taskid from subtasksassignedto where" _
              & "(personid=" & personid & " and status='I' and projid in(" _
              & " select projid from projects where(completed='F' and deleted='F')))")
        
        If Y.RecordCount > 0 Then
            MsgBox "CAN'T DELETE THE PERSON HE IS WORKING ON," & vbCrLf _
            & "ONE OR MORE ACTIVE SUBTASKS", vbOKOnly, "ERROR IN DELETION"
            Exit Sub
        End If
        X.BeginTrans
        X.Execute ("update person set exsist='F' where id=" & personid & "")
        If MsgBox("ARE YOU SURE TO DELETE?", vbYesNo, "DELETE!!!") = vbYes Then
            X.CommitTrans
            Call delclear_Click
            Call reinitialize_grid
        Else
            X.RollbackTrans
        End If
        
     End If
Exit Sub

cancel:
        MsgBox Err.Description
        X.RollbackTrans
End Sub

Private Sub exitdel_Click()
    Unload Me
End Sub

Private Sub exitedit_Click()
 Unload Me
End Sub

Private Sub exitnew_Click()
 Unload Me
End Sub

Private Sub Form_Load()
Call enable_all(False)
Call reinitialize_grid

search_flg = True
Call personnamelike_Click

selected_code = 0
Select Case person_chois
    Case "NEW":
                Me.Caption = "ADDING NEW PERSONS"
                enable_all (True)
                viewmenu.Enabled = False
                personnamelike.Enabled = False
                view.Enabled = False
                selection.Enabled = False
                edit.Enabled = False
                deletes.Enabled = False
                view.Enabled = False
                Call fillfieldorsex(cpfield, False)
                Call fillfieldorsex(csex, True)
    Case "EDIT":
                Me.Caption = "EDITING EXSISTING PERSONS"
                enable_all (True)
                viewmenu.Enabled = False
                personnamelike.Enabled = False
                view.Enabled = False
                selection.Enabled = False
                addnew.Enabled = False
                view.Enabled = False
                deletes.Enabled = False
                Call fillfieldorsex(cpfield, False)
                Call fillfieldorsex(csex, True)
                personflex.Enabled = True
    
    Case "DELETE":
                Me.Caption = "DELETEING EXSISTING PERSONS"
                delperson.Enabled = True
                exitdel.Enabled = True
                delclear.Enabled = True
                deletes.Enabled = True
                Call fillfieldorsex(cpfield, False)
                Call fillfieldorsex(csex, True)
                fperson.Enabled = True
                personflex.Enabled = True
    
    Case "VIEWX":
                Me.Caption = "VIEWING EXSISTING PERSONS"
                viewmenu.Enabled = True
                personnamelike.Enabled = True
                view.Enabled = True
                Call fillfieldorsex(cpfield, False)
                Call fillfieldorsex(csex, True)
                fperson.Enabled = True
                personflex.Enabled = True
    
    Case "VIEWNX":
                Me.Caption = "VIEWING NON-EXSISTING PERSONS"
                viewmenu.Enabled = True
                personnamelike.Enabled = True
                view.Enabled = True
                Call fillfieldorsex(cpfield, False)
                Call fillfieldorsex(csex, True)
                fperson.Enabled = True
                personflex.Enabled = True
     
     Case "SELECT":  Me.Caption = "SELECT EXSISTING PERSONS"
                     selection.Enabled = True
                     selectexit.Enabled = True
                     selectcurrent.Enabled = True
                     Call fillfieldorsex(cpfield, False)
                     Call fillfieldorsex(csex, True)
                     fperson.Enabled = True
                     personflex.Enabled = True
                    
    
    
    
    Case Else:
                MsgBox "error"
End Select
End Sub

Private Sub enable_all(flg As Boolean)

Dim I As Integer
fsearch.Visible = False

For I = 0 To Me.Count - 1
     Me.Controls(I).Enabled = flg
Next I
tpage.Value = DateValue("01/01/1975")
End Sub


Public Sub fillfieldorsex(cmb As ComboBox, sex As Boolean)

cmb.clear
If Not sex Then
    cmb.AddItem ("MECHANICAL")
    cmb.AddItem ("TECHNICAL")
    cmb.AddItem ("LOGICAL")
    cmb.AddItem ("SOFTWARE")
    cmb.AddItem ("HARDWARE")
    cmb.AddItem ("EDUCATIONAL")
    cmb.AddItem ("SOCIAL")
    
Else
    cmb.AddItem ("M")
    cmb.AddItem ("F")
End If


End Sub

Private Sub Form_QueryUnload(cancel As Integer, UnloadMode As Integer)
    If person_chois = "SELECT" Then
        If selected_code = 0 Then
            If MsgBox("NO SELECTION IS MADE/ARE YOU REALLY WANT TO QUIT?", vbYesNo, "NO SELECTION IS MADE!!!") = vbNo Then
                cancel = 1
                Exit Sub
            Else
                person_chois = ""
                If owner = "NEWPROJECT" Then
                    newproject.Show
                    newproject.lman = "No Person Selected"
                    newproject.cselectid.SetFocus
                    owner = ""
                Else
                    If owner = "TASKFORM" Then
                        tasksform.lman = "No Person Selected"
                        tasksform.Show
                        tasksform.cselectid.SetFocus
                        owner = ""
                    Else
                        If owner = "CHANGEMANAGER" Then
                            changemanagerform.sel_cde = 0
                            changemanagerform.lnewman(changemanagerform.clicked).Caption = _
                            "No Person" & vbCrLf & "Selected"
                            changemanagerform.Show
                            owner = ""
                        Else
                            If owner = "RESHEDULER" Then
                               resheduleform.Show
                               resheduleform.sel_cde = 0
                               resheduleform.tskman = Str(0)
                               owner = ""
                            End If
                        End If
                    End If
                End If
                
            End If
        Else
            person_chois = ""
            If owner = "NEWPROJECT" Then
                    newproject.txtman = Str(selected_code)
                    newproject.lman = "NAME OF MANAGER:" & selected_name
                    newproject.Show
                    newproject.pass.SetFocus
                    owner = ""
           Else
                    If owner = "TASKFORM" Then
                        tasksform.tskman = Str(selected_code)
                        tasksform.lman = "NAME OF MANAGER:" & selected_name
                        tasksform.Show
                        tasksform.savetsk.SetFocus
                        owner = ""
                    Else
                        If owner = "CHANGEMANAGER" Then
                            changemanagerform.sel_cde = selected_code
                            changemanagerform.sel_nam = selected_name
                            changemanagerform.Show
                            changemanagerform.lnewman(changemanagerform.clicked).Caption = _
                            "Reselected Manager:" & selected_name & vbCrLf & "Personid:" & Str(selected_code)
                            owner = ""
                        Else
                            If owner = "RESHEDULER" Then
                                resheduleform.sel_cde = selected_code
                                resheduleform.tskman = Str(selected_code)
                                resheduleform.sel_nam = selected_name
                                resheduleform.Show
                            End If
                        End If
                    End If
           End If
        End If
    Else
        person_chois = ""
        adminform.Show
        cancel = 0
    End If

End Sub

Private Sub personnamelike_Click()
    search_flg = Not search_flg
    If search_flg = True Then
        personnamelike.Checked = True
        fsearch.Visible = True
        fsearch.Enabled = True
        tsearch.Visible = True
        tsearch.Enabled = True
        tsearch = ""
        tsearch.SetFocus
    Else
        personnamelike.Checked = False
        fsearch.Visible = False
        fsearch.Enabled = False
        tsearch.Visible = False
        tsearch.Enabled = False

    End If
           Call reinitialize_grid
End Sub

Private Sub saveedit_Click()
On Error GoTo cancel
Dim personid As Long
Dim X As New Connection

    If Not all_valid Then
       MsgBox "ERROR IN UPDATED INFORMATION", vbCritical, "ERROR IN DETAILS!!!"
       Exit Sub
    Else
        If Trim(lpersonid.Caption) = "" Then
           MsgBox "SELECT ANY EXSISTING PERSON AND RETRY", vbCritical, "NO PERSON SELECTED!!!"
           Exit Sub
        End If
        
        personid = Val(lpersonid.Caption)
        Set X = dn.cn
        If X.State = 0 Then X.Open
        X.BeginTrans
        X.Execute ("update person set name='" & Trim(tpname) & "',address='" & Trim(tpaddress) & "',age='" & Format$(Str(tpage.Value), "dd-mmm-yyyy") & "',sex='" _
                 & Trim(csex) & "',workingfor='" & Trim(tpinstitution) & "',fieldinterested='" & Trim(cpfield.Text) & "'" _
                 & ",qualification='" & Trim(tpqualification) & "',remarks='" & Trim(tpremarks) & "' where id=" & personid & "")
           
       
       If MsgBox("SAVE UPDATED PERSONNEL INFORMATION TO DISK?", vbYesNo, "SAVE!!!") = vbYes Then
            X.CommitTrans
            Call clearnew_Click
            Call reinitialize_grid
        Else
            X.RollbackTrans
        End If
        
     End If
Exit Sub

cancel:
        MsgBox Err.Description
        If X.State = 1 Then X.RollbackTrans
End Sub

Private Sub savenew_Click()
On Error GoTo cancel
Dim X As New Connection
Dim personid As Long
    If all_valid = False Then
        MsgBox "ERROR IN ENTERED INFORMATION", vbCritical, "ERROR IN DETAILS!!!"
    Else
        personid = getmaxid("id", "person", 0, False)
        Set X = dn.cn
        If X.State = 0 Then X.Open
        X.BeginTrans
        X.Execute ("insert into person(name,address,age,sex,id,workingfor,fieldinterested" _
                 & ",qualification,remarks,exsist) values('" & Trim(tpname) & "','" & Trim(tpaddress) & "','" & Format$(Str(tpage.Value), "dd-mmm-yyyy") & "','" _
                 & Trim(csex.Text) & "'," & personid & ",'" & Trim(tpinstitution) & "','" & Trim(cpfield.Text) & "'" _
                 & ",'" & Trim(tpqualification) & "','" & Trim(tpremarks) & "','T')")
                 
       If MsgBox("SAVE PERSONNEL INFORMATION TO DISK?", vbYesNo, "SAVE!!!") = vbYes Then
            X.CommitTrans
            Call clearnew_Click
            lpersonid.Caption = Str(personid)
            Call reinitialize_grid
        Else
            X.RollbackTrans
        End If
     End If
Exit Sub

cancel:
        MsgBox Err.Description
        If X.State = adStateOpen Then X.RollbackTrans
End Sub

Private Sub selectcurrent_Click()
    If Val(lpersonid.Caption) <> 0 Then
        selected_name = tpname
        selected_code = Val(lpersonid.Caption)
        Unload Me
    Else
        MsgBox "SELECT ANY PERSON", vbOKOnly, "NO PERSON SELECTED"
    End If

End Sub

Private Sub selectexit_Click()
 Unload Me
End Sub

Private Sub tpaddress_KeyPress(pKey As Integer)
    
  If pKey = vbKeyBack Then pKey = vbKeyBack
      
End Sub


Private Sub tpage_KeyPress(KeyAscii As Integer)
  
  If check_textbox(tpage, KeyAscii, True, csex) = False Then
          MsgBox "INVALID AGE", vbOKOnly, "ERROR IN AGE!!!"
    End If
     
End Sub

Private Sub tpinstitution_KeyPress(pKey As Integer)
    If pKey = vbKeyBack Then pKey = vbKeyBack
End Sub

Private Sub tpname_KeyDown(KeyCode As Integer, Shift As Integer)
    
If KeyCode = vbKeyDown Then
    If personflex.Row <> personflex.rows - 1 Then
        personflex.Row = personflex.Row + 1
    Else
        personflex.Row = 1
    End If
    personflex.Col = 0
    personflex.ColSel = personflex.cols - 1
    Exit Sub
End If
If KeyCode = vbKeyUp Then
    If personflex.Row <> 1 Then
       personflex.Row = personflex.Row - 1
    Else
        personflex.Row = personflex.rows - 1
    End If
    personflex.Col = 0
    personflex.ColSel = personflex.cols - 1
    Exit Sub
End If

End Sub

Private Sub tpname_KeyPress(KeyAscii As Integer)

    If check_textbox(tpname, KeyAscii, False, tpaddress) = False Then
        MsgBox "INVALID PERSON NAME", vbOKOnly, "ERROR IN PERSON-NAME!!!"
     End If
    
End Sub


Public Function CHECK_COMBOBOX(cbox As ComboBox, nextcntrl As Control) As Boolean

CHECK_COMBOBOX = True
If cbox.ListIndex = -1 Then
    CHECK_COMBOBOX = False
    If person_chois <> "DELETE" And person_chois <> "VIEWNX" And person_chois <> "VIEWX" And person_chois <> "SELECT" Then
        cbox.SetFocus
    End If
Else
    If person_chois <> "DELETE" And person_chois <> "VIEWNX" And person_chois <> "VIEWX" And person_chois <> "SELECT" Then
        nextcntrl.SetFocus
    End If
End If


End Function
Public Function check_textbox(txtbox As TextBox, pKey As Integer, numerical As Boolean, nextcntrl As Control) As Boolean
 
  check_textbox = True
  If pKey = 13 Then
      If numerical = True Then
        If Val(txtbox) <> 0 Then
              nextcntrl.SetFocus
        Else
              check_textbox = False
              txtbox.SetFocus
        End If
      Else
        If Trim(txtbox) <> "" Then
              nextcntrl.SetFocus
        Else
            check_textbox = False
            txtbox.SetFocus
        End If
      End If
  pKey = 0
  Else
      If Chr$(pKey) = "'" Then
        pKey = 0
      End If
      
      If pKey = vbKeyBack Then
         pKey = vbKeyBack
      Else
        If numerical = True Then
            If pKey < 48 Or pKey > 57 Then
                pKey = 0
            End If
        End If
        
      End If
        
 End If

End Function



Private Sub tpqualification_KeyPress(KeyAscii As Integer)
    If check_textbox(tpqualification, KeyAscii, False, tpremarks) = False Then
        MsgBox "INVALID QUALIFICATION", vbOKOnly, "ERROR IN ENTERED QUALIFICATION!!!"
     End If
    
End Sub


Private Sub tpremarks_KeyPress(pKey As Integer)
    If pKey = vbKeyBack Then pKey = vbKeyBack
End Sub


Private Function all_valid() As Boolean

    If Trim(tpname) <> "" And Trim(tpaddress) <> "" And Trim(tpinstitution) <> "" And cpfield.ListIndex <> -1 _
    And Trim(tpqualification) <> "" And Trim(tpremarks) <> "" And tpage.Value >= CDate("01/01/1910") And csex.ListIndex <> -1 Then
            all_valid = True
    Else
            all_valid = False
    End If
   
End Function

Private Sub reinitialize_grid()
On Error GoTo cancel
Dim X As New Connection
Dim Y As New Recordset

Set X = dn.cn
If X.State = 0 Then X.Open

If person_chois = "VIEWNX" Then
  If Not search_flg Then
    Set Y = X.Execute("select * from person where exsist='F'")
  Else
    Set Y = X.Execute("select * from person where (exsist='F' and name like '" & tsearch & "%')")
  End If
Else
   If Not search_flg Then
        Set Y = X.Execute("select * from person where exsist='T'")
    Else
        Set Y = X.Execute("select * from person where (exsist='T' and name like '" & tsearch & "%')")
    End If
End If

If (Y.BOF And Y.EOF) Then
    personflex.Enabled = False
    personflex.rows = 2
    personflex.clear
    personflex.cols = Y.Fields.Count + 1
    personflex.FixedRows = 1
Else
    personflex.Enabled = True
    personflex.rows = 30
    personflex.ColWidth(2) = 2500
    personflex.ColWidth(6) = 1800
    personflex.ColWidth(7) = 1800
    personflex.ColWidth(9) = 2500
    personflex.cols = Y.Fields.Count + 1
    personflex.FixedRows = 1
    Set personflex.Recordset = Y
    personflex.Col = 1
    personflex.Sort = 1
End If
Exit Sub

cancel:
    MsgBox Err.Description
End Sub
Private Sub personflex_Click()
    personflex.cols = 10
    If person_chois = "EDIT" Or person_chois = "DELETE" Or person_chois = "VIEWX" Or person_chois = "VIEWNX" Or person_chois = "SELECT" Then
        If personflex.Row <> -1 Then
             With personflex
                tpname = Trim(.TextMatrix(.Row, 1))
                tpaddress = Trim(.TextMatrix(.Row, 2))
                tpinstitution = Trim(.TextMatrix(.Row, 6))
                tpqualification = Trim(.TextMatrix(.Row, 8))
                tpremarks = .TextMatrix(.Row, 9)
                tpage = CDate(Format$(.TextMatrix(.Row, 3), "mm/dd/yyyy"))
                lage.Caption = "Age:" & Str(Abs(DateDiff("yyyy", tpage.Value, DateValue(Format$(Now, "mm/dd/yyyy")))))
                lpersonid.Caption = Trim(.TextMatrix(.Row, 5))
                cpfield.ListIndex = findindexofcombolist(cpfield, Trim(.TextMatrix(.Row, 7)))
                csex.ListIndex = findindexofcombolist(csex, Trim(.TextMatrix(.Row, 4)))
           End With
      End If
    End If
    
End Sub

Private Sub tsearch_change()
    Call reinitialize_grid
End Sub

Private Sub view_Click()
  Unload Me
End Sub

