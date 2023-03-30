VERSION 5.00
Begin VB.Form frmSplash 
   BackColor       =   &H8000000A&
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   5805
   ClientLeft      =   1080
   ClientTop       =   1080
   ClientWidth     =   8640
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frmSplash.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5805
   ScaleWidth      =   8640
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   50
      Left            =   4065
      Top             =   2670
   End
   Begin VB.Image Image2 
      Appearance      =   0  'Flat
      Height          =   225
      Left            =   -15750
      Picture         =   "frmSplash.frx":0442
      Stretch         =   -1  'True
      Top             =   4935
      Width           =   15870
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   4920
      Width           =   8685
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "version 1.0"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   3315
      TabIndex        =   1
      Top             =   1560
      Width           =   975
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Copyright © 2005 - 2010 De Paul Institiute Of Science and Technology"
      Height          =   255
      Left            =   1733
      TabIndex        =   0
      Top             =   5280
      Width           =   5175
   End
   Begin VB.Image Image1 
      Height          =   5805
      Left            =   -15
      Picture         =   "frmSplash.frx":46F6
      Stretch         =   -1  'True
      Top             =   0
      Width           =   8670
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Public dbe As New DBEngine
Dim dopt As Long
Dim interval As Integer
Dim def As Boolean
Dim trial As Integer
Dim uload As Boolean
Dim know As Boolean


Private Sub Form_activate()
On Error GoTo xit
Dim tmp As Long

Timer1.Enabled = False
Me.Visible = False
def = False
If dn.cn.state = adStateOpen Then dn.cn.Close

If Not inregistry() Then
        dopt = MsgBox("Use default database for OpTech?" + vbCrLf + vbCrLf + "Yes:Will select default database." + vbCrLf + "No:Will allow you to specify the database to be used." + vbCrLf + "Cancel:I will specify later.", vbYesNoCancel, "No database connected!!!")
        If dopt = vbNo Then
            registry.Show
            Unload Me
            Exit Sub
        ElseIf dopt = vbYes Then
            def = True
            trial = 1
            If Not Add_default("\sdbase\dbOpTech") Then
                GoTo xit
            End If
        Else
            Call del_registry
            Unload Me
            Exit Sub
        End If
End If
    Me.Visible = True
    interval = 0
    Timer1.Enabled = True
Exit Sub

xit:
    If def And trial <= 1 Then
        trial = 2
        know = True
        If Not Add_default("\sdbase\dbOpTech.mdb") Then
            If uload Then
                Unload Me
                Exit Sub
            End If
            
            If Not know Then
                tmp = vbYes
            Else
                tmp = MsgBox("Default database not found in the path specified!!!" + vbCrLf + vbCrLf + "Do you like to create a new database?", vbYesNo, "Create a new Database?")
            End If
            
            If tmp = vbNo Then
                Call Form_activate
                Exit Sub
            Else
                Call create_directory(App.path + "\sdbase")
                Call dbe.CreateDatabase(App.path + "\sdbase\dbOpTech", dbLangGeneral, dbVersion30)
                If Not Add_default("\sdbase\dbOpTech.mdb") Then
                    trial = 3
                End If
            End If
        End If
        interval = 0
        Me.Visible = True
        Timer1.Enabled = True
        Exit Sub
    End If

MsgBox "ERROR:" & IIf(Err.Description <> "", Err.Description, "Undefined Error!!!") & vbCrLf & vbCrLf & "ERROR NUMBER:" & IIf(Err.Number <> 0, str(Err.Number), "Unknown error number!!!") & _
    vbCrLf & vbCrLf & "SOURCE OF ERROR:" & IIf(Err.Source <> "", Err.Source, "Source of error; unknown!!!"), vbOKOnly, "OpTech:DATA BASE CONNECTION ERROR", Err.HelpFile, Err.HelpContext

Call del_registry
End Sub


Private Sub timer1_Timer()
On Error GoTo label

If interval <= 60 Then
    Image2.left = Image2.left + 250
End If
    
    interval = interval + 1
    If interval = 30 Then
          If dn.cn.state = adStateOpen Then dn.cn.Close
          If dn.cn.state = adStateClosed Then
                               
                db_type_oracle = IIf(GetSetting("OT", "data_base", "dprovider", "microsoft.jet.oledb.4.0") = "MSDAORA.1", True, False)
                
                If db_type_oracle Then
                        Call SendKeys("{ESC}")
                        dno.cno.Open "Provider=" & GetSetting("OT", "data_base", "dprovider", "microsoft.jet.oledb.4.0") & ";" & _
                                     "Data Source=" & GetSetting("OT", "data_base", "dsource", "dbOpTech.mdb") & ";User Id=" & _
                                     GetSetting("OT", "data_base", "duser", "admin") & ";Password=" & _
                                     GetSetting("OT", "data_base", "dpass", "")
            
                        Set dn.cn = dno.cno
                
                Else
                        'Call dbe.CreateDatabase(App.path + "\sdbase\tmpdbOpTech", dbLangGeneral)
                        'Call dbe.CompactDatabase(GetSetting("OT", "data_base", "dsource", "dbOpTech.mdb"), App.path + "\sdbase\tmpdbOpTech")
                        'dbe.RepairDatabase GetSetting("OT", "data_base", "dsource", "dbOpTech.mdb")
                        Call SendKeys("{ESC}")
                        dna.cna.Open "Provider=" & GetSetting("OT", "data_base", "dprovider", "microsoft.jet.oledb.4.0") & ";" & _
                                     "Data Source=" & GetSetting("OT", "data_base", "dsource", "dbOpTech.mdb") & ";User Id=" & _
                                     GetSetting("OT", "data_base", "duser", "admin") & ";Password=" & _
                                     GetSetting("OT", "data_base", "dpass", "")
           
                        Set dn.cn = dna.cna
                End If
          End If
    End If
    
    If interval > 60 Then
        Timer1.Enabled = False
        or_form1.Show
        Unload Me
        Exit Sub
    End If
Exit Sub

label:
   
   Call del_registry
   MsgBox "Error found!!!" & vbCrLf & "UNLOADING, SORRY FOR THE INCONVINENCE.(Database connection failed)." _
   & vbCrLf & "DESCRIPTION OF ERROR FOLLOWS" & vbCrLf & vbCrLf & "ERROR:" & Err.Description & vbCrLf & "ERROR-NO:" & Err.Number & vbCrLf _
   & "ERROR SOURCE:" & Err.Source & vbCrLf & "ERROR HELP FILE:" & Err.HelpFile & vbCrLf & "ERROR HELP CONTEXT:" & Err.HelpContext & vbCrLf & vbCrLf & _
   "Note: Rerunning of OpTech may resolve the problem!!!", vbOKOnly, "OpTech, detected an error!"
    
    Dim Form As Form
    For Each Form In Forms
        Unload Form
    Next Form

End Sub

Private Function Add_default(dbname As String) As Boolean
On Error GoTo xit
Dim xist As Boolean
Dim fobj As Object
            
            xist = False
            uload = False
            Open App.path + dbname For Input As #1
            Close #1
            xist = True
            Call add_to_registry("Microsoft.Jet.OLEDB.4.0", App.path + dbname, "admin", "")
            Call SendKeys("{ESC}")
            dna.cna.Open "Provider=" & GetSetting("OT", "data_base", "dprovider", "microsoft.jet.oledb.4.0") & ";" & _
                                     "Data Source=" & GetSetting("OT", "data_base", "dsource", "dbOpTech.mdb") & ";User Id=" & _
                                     GetSetting("OT", "data_base", "duser", "admin") & ";Password=" & _
                                     GetSetting("OT", "data_base", "dpass", ";Open Mode=DB_MODE_SHARE_EXCLUSIVE")
         
            db_type_oracle = False
            Set dn.cn = dna.cna
            Call create_main_tables_access
            Add_default = True
Exit Function
xit:
    If xist Then
        If MsgBox("Unable to open the default database file " + App.path + dbname + "(click Help for more information)" + vbCrLf + vbCrLf + "Select Yes, if you want to delete the default database file & allow OpTech to create a new one" _
        + vbCrLf + vbCrLf + "Select No, if you want to exit OpTech with out deleting the default database file", vbYesNo + vbMsgBoxHelpButton, "Unable to open default database!!!", Err.HelpFile, Err.HelpContext) = vbYes Then
            Set fobj = CreateObject("Scripting.FileSystemObject")
            fobj.DeleteFile App.path + dbname, True
            know = False
        Else
            Call del_registry
            uload = True
        End If
    End If
    Add_default = False
End Function

Private Sub create_directory(dir_ As String)
On Error GoTo xit
    
        MkDir dir_
        
Exit Sub
xit:
    Exit Sub
End Sub

