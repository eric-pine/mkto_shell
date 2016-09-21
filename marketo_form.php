<?php
 $authToken_in = file_get_contents("/usr/share/zabbix/marketo/auth_token.json");
 $landingPages_in = file_get_contents("/usr/share/zabbix/marketo/landingPages.json");
 $authToken_obj = json_decode($authToken_in, TRUE);
 $landingPages_obj = json_decode($landingPages_in, TRUE);
 //$output = prettyPrint($landingPages_in);
 $authToken = $authToken_obj["access_token"];
?>
<b>Market REST API interface </b>

<div id="mkto_body">

  <form>
    
  Simulate Only <span class="fineprint">(read data but only output here)</span><input type="checkbox" value="selected" name="simulate"><br>
  Access Token <input type="text" name="access_token_field" value=<?php echo $authToken;?> style= "width: 300px;"><br>
  Landing Page Name <input type="text" name="landingpage_name_match"><br>
  Field to Change <input type="text" name="field_to_change"><br>
  Change the string <input type="text" name="string_to_find"> to <input type="text" name="change_string_to"><br>
  
  </form>
  
  <div id="results_outer">
  <b>Marketo Landing Pages
  <div id="results">
  
 <?php
 //echo "Total Landing Pages:";
 //$page_result = $landingPages_obj["result"];
 //$total_pages = count($page_result[0]);
 //echo $total_pages; 
 function prettyPrint( $json )
{
    $result = '';
    $level = 0;
    $in_quotes = false;
    $in_escape = false;
    $ends_line_level = NULL;
    $json_length = strlen( $json );

    for( $i = 0; $i < $json_length; $i++ ) {
        $char = $json[$i];
        $new_line_level = NULL;
        $post = "";
        if( $ends_line_level !== NULL ) {
            $new_line_level = $ends_line_level;
            $ends_line_level = NULL;
        }
        if ( $in_escape ) {
            $in_escape = false;
        } else if( $char === '"' ) {
            $in_quotes = !$in_quotes;
        } else if( ! $in_quotes ) {
            switch( $char ) {
                case '}': case ']':
                    $level--;
                    $ends_line_level = NULL;
                    $new_line_level = $level;
                    break;

                case '{': case '[':
                    $level++;
                case ',':
                    $ends_line_level = $level;
                    break;

                case ':':
                    $post = " ";
                    break;

                case " ": case "\t": case "\n": case "\r":
                    $char = "";
                    $ends_line_level = $new_line_level;
                    $new_line_level = NULL;
                    break;
            }
        } else if ( $char === '\\' ) {
            $in_escape = true;
        }
        if( $new_line_level !== NULL ) {
            $result .= "\n".str_repeat( "\t", $new_line_level );
        }
        $result .= $char.$post;
    }

    return $result;
}
 
 echo "<textarea cols=200 rows=250>";
 var_dump($authToken_obj);
 var_dump($landingPages_obj);
 //echo $output;
 echo "</textarea>";
 ?>
 </div>
 </div>
</div>