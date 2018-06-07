Function Main(args)
    If args.Count > 0 Then
        Select Case args.Item(0)
            Case "-of"
                Call OpenFolder(args.Item(1))
            Case "-run"
                If args.Count = 3 Then Call RunProgram(args.Item(1), args.Item(2), Null)
                If args.Count = 4 Then Call RunProgram(args.Item(1), args.Item(2), Array(args.Item(3)))
                If args.Count = 5 Then Call RunProgram(args.Item(1), args.Item(2), Array(args.Item(3), args.Item(4)))
                If args.Count = 6 Then Call RunProgram(args.Item(1), args.Item(2), Array(args.Item(3), args.Item(4), args.Item(5)))
                If args.Count = 7 Then Call RunProgram(args.Item(1), args.Item(2), Array(args.Item(3), args.Item(4), args.Item(5), args.Item(6)))
        End Select
    End If
    Main = 0
End Function

Sub OpenFolder(filename)
    Set shell = wscript.CreateObject("Shell.Application")
    shell.ShellExecute "explorer", " /select,""" & filename & """", "", "", 1
    Set sell = Nothing
End Sub

Sub RunProgram(program, workDir, params)
    Set shell = wscript.CreateObject("Shell.Application")


    If IsArray(params) Then
        If UBound(params) = 0 Then shell.ShellExecute program, Q(params(0)), workDir, "", 1
        If UBound(params) = 1 Then shell.ShellExecute program, Q(params(0)) & " " & Q(params(1)), workDir, "", 1
        If UBound(params) = 2 Then shell.ShellExecute program, Q(params(0)) & " " & Q(params(1)) & " " & Q(params(2)), workDir, "", 1
        If UBound(params) = 3 Then shell.ShellExecute program, Q(params(0)) & " " & Q(params(1)) & " " & Q(params(2)) & " " & Q(params(3)), workDir, "", 1
    Else
        shell.ShellExecute program, "", workDir, "", 1
    End If
    Set sell = Nothing
End Sub

Function Q(s)
    Q = Chr(34) & s & Chr(34)
End Function

WScript.Quit(Main(WScript.Arguments))