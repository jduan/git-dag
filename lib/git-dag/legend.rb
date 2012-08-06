TEMPLATE = <<HERE
{ rank = same;
    Legend [shape=none, margin=0, label=<
    <TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0" CELLPADDING="4">
     <TR>
      <TD COLSPAN="2" BGCOLOR="grey"><B>Legend</B></TD>
     </TR>
     <TR>
      <TD><FONT COLOR="black">ellipse</FONT></TD>
      <TD>regular commit</TD>
     </TR>
     <TR>
      <TD><FONT COLOR="red">ellipse</FONT></TD>
      <TD>merge commit</TD>
     </TR>
     <TR>
      <TD><FONT COLOR="blue">box</FONT></TD>
      <TD>branch</TD>
     </TR>
     <TR>
      <TD><FONT COLOR="green">circle</FONT></TD>
      <TD>tag</TD>
     </TR>
    </TABLE>
   >];
  }
HERE
module GitDag
  module Legend
    def self.dot_output
      TEMPLATE
    end
  end
end
