Imports System
Imports System.Text.RegularExpressions

Module HtmlParser
    Sub Main()
        Dim insideBody As Boolean = False
        Dim insideScript As Boolean = False
        Dim line As String

        Console.Clear()
        Console.BackgroundColor = ConsoleColor.Yellow
        Console.ForegroundColor = ConsoleColor.Black
        Console.WriteLine(vbCrLf & vbCrLf)

        Do
            line = Console.ReadLine()
            If line Is Nothing Then Exit Do

            ' Verifica início da tag <body>
            If Not insideBody Then
                If line.IndexOf("<body", StringComparison.OrdinalIgnoreCase) >= 0 Then
                    insideBody = True
                End If
            End If

            If insideBody Then
                ' Verifica início e fim de <script>
                If line.IndexOf("<script", StringComparison.OrdinalIgnoreCase) >= 0 Then
                    insideScript = True
                End If
                If line.IndexOf("</script", StringComparison.OrdinalIgnoreCase) >= 0 Then
                    insideScript = False
                    Continue Do
                End If

                If Not insideScript Then
                    ' Nova linha em certas tags
                    If Regex.IsMatch(line, "(?i)<br|<p|</p") Then
                        Console.WriteLine()
                    End If

                    ' Extrai todos os href="..."
                    Dim hrefs = Regex.Matches(line, "href\s*=\s*""([^""]*)""", RegexOptions.IgnoreCase)
                    For Each match As Match In hrefs
                        Console.WriteLine(match.Groups(1).Value)
                    Next

                    ' Remove tags HTML
                    Dim textOnly As String = Regex.Replace(line, "<.*?>", "")
                    ' Evita imprimir linhas vazias múltiplas
                    If textOnly.Trim().Length > 0 Then
                        Console.Write(textOnly & " ")
                    End If
                End If
            End If
        Loop
    End Sub
End Module
