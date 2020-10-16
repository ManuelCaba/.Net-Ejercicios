<?php

$dom = new DOMDocument('1.0');//Create new document with specified version number
echo $dom->saveHTML();

$p_text = 'This is a paragraph.';
$p = $dom->createElement('p', $p_text);//Create new <p> tag with text

$dom->appendChild($p);

echo $dom->saveHTML();

?>