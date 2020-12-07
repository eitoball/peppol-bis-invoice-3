declare namespace saxon = "http://saxon.sf.net/";
declare namespace iso = "http://purl.oclc.org/dsdl/schematron";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "text";


for
$x in //iso:pattern/iso:rule/iso:assert

let $RuleId := string($x/@id)
let $rule := replace(normalize-space(string($x/../@context)), '\|', '\\|')
let $flag := string($x/@flag)
let $assert := string($x/@test)
let $tekst := tokenize(normalize-space($x/text()), '\]\-')[2]

where starts-with($x/@id, 'UBL-') or starts-with($x/@id, 'CII-')
order by $x/@id

return
    if (contains($x/@diagnostics, concat($RuleId, '-ja'))) then
      let $diagnostic := //iso:diagnostics/iso:diagnostic[@id=concat($RuleId, '-ja')]/text()
      let $tekst := tokenize(normalize-space($diagnostic), '\]\-')[2]
      return concat("| ", $RuleId, " *(", $flag, ")* | ", $tekst, "&#10;")
    else
      concat("| ", $RuleId, " *(", $flag , ")* | ", $tekst, " &#10;")
