<#include "../../include/imports.ftl">

<style>
html {
	position: relative;
	min-height: 100%;
}

body {
	margin: 0 0 101px;
	font: 13px Arial; 
	color: #666666; /* not this color */
}

/* ----------------
     HEADER TOP
   ---------------- */
#header-top {
	padding-top: 10px; /*do padding for  elements if problem with formatting*/
	padding-left: 5px;
	background-color: #F1F1F1;
	height: 50px;
	border-bottom: 1px solid #E4E4E4;
}

.header-left {
	float: left;
}

#logo {
	display: inline-block;
	margin-left: 10px;
	margin-top: 2px;
}

#search-form {
	display: inline-block;
	top: -14px; /*move searchbar up/down*/
	left: 14px; /*move searchbaor left/right */
	width:584px;
	height: 38px;
	position: relative;
}

#search-form input {
	width: 564px; /*20px less than #search-form width*/
	height: 100%;
	border: 1px solid #DDDDDD;
	padding: 0 10px;
	font-size: 16px;
}

#voice {
	position: relative;
	width: 100%;
	height: 100%;
}

#voice img {
	position: absolute;
	top: -96%; 
	right: 21px;
}

#search-button {
	position: relative;
	width: 100%;
	height: 100%;
}

#search-button img {
	position: absolute;
	top: -197%;
	right: -20px;
	margin-top: -2px;

}

#search-form input:hover {
	border: 1px solid #AEAEAE;
}

.header-right {
	float: right;
	position: relative;
	right: 10px;

}

.header-style {
	display: inline-block;
	margin-right: 20px; /*space between icons */
	text-decoration: none;
}

.header-right p:first-child {
	position: relative;
	top: -10px;
}

.header-right a:nth-child(2) {
	position: relative;
	top: -5px;
}

.header-right a:nth-child(3) {
	position: relative;
	top: -5px;
}

/* ----------------
     HEADER BOTTOM
   ---------------- */

#header-bottom {
	height: 60px;
	border-bottom: 1px solid #E4E4E4;
}

.header2-left {
	float: left;
	padding-left: 100px;
	padding-top: 25px;
}

.header2-left a {
	text-decoration: none;
	color: #837777;
	margin-left: 25px; /*affects padding-left */
}

.header2-left a:first-child {
	font-weight: bold;
	color: #4285F4;
	padding-bottom: 17px;
	border-bottom: 3px solid #4285F4;
}

.header2-left a:visited {
	color: #666666;
	text-decoration: none;
}

.header2-left a:hover {
	text-decoration: none;
	color: black;
}

.header2-right {
	float: right;
	padding-top: 15px;
	padding-right: 25px;
}

.header2-right a:first-child {
	margin-right: -4px;
}

.header2-right a:nth-child(3) {
	margin-left: 10px;
}

/* ----------------
     	RESULTS
   ---------------- */

#container {
	padding-left: 125px;
	width: 550px;
	padding-bottom: 20px; /*container to footer distance */
}

.result {
	margin-top: 25px;
}

.result a:first-child {
	font-size: 18px;
	text-decoration: none;
	color: #1A0DAB;
}

.result a:first-child:visited {
	color: #660099;
}

.result a:first-child:hover {
	text-decoration: underline;
}

.result p:nth-child(2) { /*link*/
	display: inline-block;
	color: #006621;
	font-size: 14px;
}

.result a:nth-child(3) { /*website title*/
	display: inline-block;
	text-decoration: none;
	color: #777777;
}

.result a:nth-child(3):hover {
	color: black;
}

.result p {
	margin: 2px;
}

.result:nth-child(12) {
	padding-bottom: 18px;
	border-bottom: 1px solid #E4E4E4;
}
/*
.result:nth-child(6) p:nth-child(2) { /*special case for 4th result as link displays inline with short title */
	display: block;
	/*margin-bottom: -13px;*/
}

.result:nth-child(6) p:nth-child(4) { /*fix line spacing for above special case */
	margin-top: -13px;
}
*/
/* ----------------
     RELATED SEARCHES
   ---------------- */

#related > p {
	font-size: 18px;
	margin-bottom: 0;
}

#related table {
	width: 450px; /*width between columns */
}
#related a {
	text-decoration: none;
	color: #1A0DAB;
}

#related a:hover {
	text-decoration: underline;
}

#related table {
	padding-top: 10px; /*equal top and bottom padding */
	padding-bottom: 20px;
	/*font-weight: bold;*/
}

/* ----------------
     PAGE NUMBERS
   ---------------- */

#pages {
	width: 500px;
	border-top: 1px solid #E4E4E4;
}

#pages img {
	display: block;
	margin: auto;
	padding-top: 30px;
}

#numbers {
	margin-top: 3px;
	margin-left: 135px;
}

#pages a {
	display: inline-block;
	
	text-decoration: none;
	color: #4285F4;
	margin-right: 8.5px; /*space between numbers */
	padding-bottom: 10px;
}

#pages a:first-child {
	color: black;
}


#pages a:nth-child(11) { 
	margin-left: 50px; /*space before "next" */
}

#pages a:hover {
	text-decoration: underline;
}

/* ----------------
    	FOOTER
   ---------------- */


#footer {
	position: relative;
	left: 0;
	bottom: 0;
	height: 85px;
	width: 100%;
	background-color: #F2F2F2;
	border-top: 1px solid #E4E4E4;
	font: 13px Arial;
}

#footer-content {
	padding-left: 125px;
	padding-top: 10px;
}

#footer-content p {
	display: inline-block;
	color: #AAAAAA;
}

#footer-content a {
	text-decoration: none;
	color: #666666;
	margin-right: 20px;
}

#footer a:visited {
	color: #666666;
}

#footer a:hover {
	text-decoration: none;
	color: black;
}

#footer a:nth-child(2){
	display: inline-block;
}

#footer a:nth-child(3) {
	display: inline-block;
	margin-left: -20px;
}

/*
* {
	border: 1px solid black;
} */

/* http://meyerweb.com/eric/tools/css/reset/ 
   v2.0 | 20110126
   License: none (public domain)
*/

html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td,
article, aside, canvas, details, embed, 
figure, figcaption, footer, header, hgroup, 
menu, nav, output, ruby, section, summary,
time, mark, audio, video {
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	font: inherit;
	vertical-align: baseline;
}
/* HTML5 display-role reset for older browsers */
article, aside, details, figcaption, figure, 
footer, header, hgroup, menu, nav, section {
	display: block;
}
body {
	line-height: 1;
}
ol, ul {
	list-style: none;
}
blockquote, q {
	quotes: none;
}
blockquote:before, blockquote:after,
q:before, q:after {
	content: '';
	content: none;
}
table {
	border-collapse: collapse;
	border-spacing: 0;
}

</style>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="programming/reset2.css">
	<link rel="stylesheet" type="text/css" href="results.css">
		<title>${document.searchterm} - Google Search</title>
</head>
<body>
	<div id="wrap">
		<div id="header-top">
			<div class="header-left">
				<a id="logo" href="#"><img src="<@hst.webfile path="images/logo-small.png"/>"></a>
				<div id="search-form">
					<input type="text" name="text" input value="${document.searchterm}">
					<div id="voice">
						<a href="#"><img src="<@hst.webfile path="images/voice.png"/>"></a>
					</div>
					<div id="search-button">
						<a href="#"><img src="<@hst.webfile path="images/searchb-logo.png"/>"></a>
					</div>
				</div>
			</div>
			<div class="header-right">
				<p class="header-style">Michelle</p>
				<a class="header-style"><img src="<@hst.webfile path="images/apps.png"/>"></a>
				<a class="header-style"><img src="<@hst.webfile path="images/alerts.png"/>"></a>
				<a class="header-style"><img src="<@hst.webfile path="images/profile.png"/>"></a>
				<br style="clear: both" /> <!-- clear floats -->
			</div>
		</div>
		

		<div id="header-bottom">
			<div class="header2-left">
				<a href="#">All</a>
				<a href="#">Videos</a>
				<a href="#">Maps</a>
				<a href="#">Shopping</a>
				<a href="#">News</a>
				<a href="#">More</a>
				<a href="#">Search tools</a>
			</div>
			<div class="header2-right">
				<a href="#"><img src="<@hst.webfile path="images/priv.png"/>" alt="Currently showing private results"></a> 
				<a href="#"><img src="<@hst.webfile path="images/glob.png"/>" alt="Hide private results"></a>
				<a  href="#"><img src="<@hst.webfile path="images/settings.png"/>" alt="Options"></a>
			</div>
		</div>

		<div id="container">
			<p>About 14,200,000 results (0.51 seconds)<p>
			
			<#list document.result as results>
   				<div class="result">
					<a href="${results.link}">${results.title}</a>
					<p>${results.link}</p>
					<p><@hst.html hippohtml=results.desc/></p>
				</div>
			</#list>			
			
			
			<div class="result">
				<a href="#">Smartwatch - Wikipedia</a>
				<p>https://en.wikipedia.org/wiki/Smartwatch</p>
				<a href="#"></a>
				<p>A smartwatch is a wearable computer in the form of a wristwatch; modern smartwatches provide a local touchscreen interface for daily use, while an ...</p>
			</div>
			<div class="result">
				<a href="#">Buy Smart Watches Online | Wearable Smart Watches - Reliance Digital</a>
				<p>https://www.reliancedigital.in/smart-watches/c/S10171310</p>
				<a href="#"></a>
				<p>Buy Latest Smart Watches Online from best brands at discounted prices in India. Get attractive deals on smart watches at Reliance Digital. Shop NOW!</p>
			</div>
			<div class="result">
				<a href="#">All Smartwatches – Best Buy</a>
				<p>https://www.bestbuy.com › Wearable Technology › Smartwatches & Accessories</p>
				<a href="#"></a>
				<p>Samsung - Galaxy Watch Smartwatch 46mm Stainless Steel - Silver - Front_Zoom ... Fitbit - Versa Smartwatch 34mm Aluminum - Black/Black.</p>
			</div>
			<div class="result">
				<a href="#">Smart Watches | Amazon.com</a>
				<p>https://www.amazon.com/smart-watches/b?ie=UTF8&node=7939901011</p>
				<a href="#"></a>
				<p>Shop through a wide selection of Smart Watches at Amazon.com. Free shipping and free returns on eligible items.</p>
			</div>
			<div class="result">
				<a href="#">Best smartwatch 2019: the top choices you can buy | TechRadar</a>
				<p>https://www.techradar.com/.../best-smart-watches-what-s-the-best-wearable-tech-for-y...</p>
				<a href="#"></a>
				<p>Jan 2, 2019 - A smartwatch is the ultimate smartphone accessory. It can tell the time, of course, but it can also beam important notifications straight to your ...</p>
			</div>
			<div class="result">
				<a href="#">Smartwatch Devices & Accessories - Best Buy</a>
				<p>https://www.bestbuy.com › Wearable Technology › Smartwatches & Accessories</p>
				<a href="#"></a>
				<p>Shop Best Buy for a stylish smartwatch that can relay information from select iOS and Android smartphones.</p>
			</div>
			<div class="result">
				<a href="#">Smart Watches - Walmart.com</a>
				<p>https://www.walmart.com/browse/electronics/smart-watches/3944_1229723_8780847</p>
				<a href="#"></a>
				<p>Shop for Smart Watches in Wearable Technology. Buy products such as Tagital T6 Smart Watch Bluetooth Wrist Watch with Camera For ...</p>
			</div>
			
			<div id="pages">
				<img src="<@hst.webfile path="images/pages.png"/>">
				<div id="numbers">
					<a href="#">1</a>
					<a href="#">2</a>
					<a href="#">3</a>
					<a href="#">4</a>
					<a href="#">5</a>
					<a href="#">6</a>
					<a href="#">7</a>
					<a href="#">8</a>
					<a href="#">9</a>
					<a href="#">10</a>
					<a href="#">Next</a>
				</div>
			</div>	

			
		</div>

	</div>
	<div id="footer">
		<div id="footer-content">
			<p>California - From your Internet address - </p>
			<a href="#">Use precise location - </a>
			<a href="#">Learn more</a><br>
			<a href="#">Help</a>
			<a href="#">Send feedback</a>
			<a href="#">Privacy</a>
			<a href="#">Terms</a>
		</div>
	</div>
</body>
</html>

<!--



-->
