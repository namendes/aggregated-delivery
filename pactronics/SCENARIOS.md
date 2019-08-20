# Starter Store Boot Test Cases

## Test Case: Create category decorator document

1. Visit the CMS at http://localhost:8080/cms/
1. Click on the content button on the left side panel
1. Create a new translated folder below the root content folder with name 'categories' if it doesn't exist.
1. Create a new "Products Category" document in the categories folder called Thanksgiving
1. Fill all the document fields. In case of External Resource Configurations, select the mapping 
file in the administration folder related to Commercetools (you need to have valid credential 
defined in the crisp resource!). Once the mapping has been selected, click on the Related External 
Documents browse button. When the modal window is open, select the Thanksgiving entry and click ok. 
1. Save and close the category decorator document
1. Click on the View item on the top bar of the document perspective: preview this document in the current project
1. Now you should be able to see the category page, containing the category related products.


## Test Case: Create product decorator document

1. Visit the CMS at http://localhost:8080/cms/
1. Click on the content button on the left side panel
1. Create a new translated folder below the root content folder with name 'products' if it doesn't exist.
1. Create a new "Products Detail" document in the products folder called Inter Cap
1. Fill all the document fields. In case of External Resource Configurations, select the mapping 
file in the administration folder related to Commercetools (you need to have valid credential 
defined in the crisp resource!). Once the mapping has been selected, click on the Related External 
Documents browse button. When the modal window is open, search for 'inter', select the first result entry and click ok. 
1. Save and close the product decorator document
1. Click on the View item on the top bar of the document perspective: preview this document in the current project
1. Now you should be able to see the product page, containing the category related products.

## Test Case: Create a navigation header using the category menu component

Background: This test case requires the creation of a category document (Test case 1)

1. Visit the CMS at http://localhost:8080/cms/
1. Open Channel Manager and visit the home page
1. Click on the show component button on the top-right 
1. Drop the Categories Menu component in the Menu Nav container (the top container, just below the top bar)
1. Click on the Categories Menu component just dropped
1. Regarding the Template property, select Starter store categories menu
1. Regarding the Menu name, type categories
1. Regarding the Resource Name property, select Commercetools
1. Save and close the component property dialog.
1. Click on the orange burger placed on the right section of the container
1. Add a new menu item, by clicking on the orange burger on the bottom right
1. Fill the title with Thanksgiving, click internal link and select the Thanksgiving document created in a previouse 
test case (You will find the document under the documents tab)
1. Save the menu and go back to channel manager
1. Now you should be able to see the Thanksgiving menu item in the nav: if you click on it, you should get redirected 
to the thanksgiving category detail page  

Suppose you want to add to the navigation menu a link to a home page (Sitemap Item)
1. If channel manager components are not in edit mode, click on the show component button on the top-right 
1. Click on the orange burger placed on the right section of the container
1. Add a new menu item, by clicking on the orange burger on the bottom right
1. A new menu entry should appear: fill the title field with 'Homepage'
1. In the select internal link dialog, under the Pages (Sitemap Items) option select starterstoreboot -> Home  
1. Save the menu item just created and go back to channel manager
1. Now you should be able to see the Homepage menu item in the nav: if you click on it, you should get redirected 
to the homepage 

## Test Case: Create department page
1. Visit the CMS at http://localhost:8080/cms/
1. Open Channel Manager and click on Page->New on the top left
1. Fill all the required fields
1. 'Simple Content Page' template should be selected. (Set by default it template page property is not shown by Channel Manager)
1. Once the new landing page is created, click on the show components button (top right)
1. Drop the Categories Highlight component in the Menu Nav container (the top container, just below the top bar)
1. Click on the Categories Highlight component just dropped
1. Regarding the template property, select Flat Carousel
1. Regarding the Document item 1 property, select the Commercetools example category document
1. Regarding the Resource Name property, select Commercetools
1. Save and close the component property dialog. You should be able to see the new category: as you can imagine
yu can define more categories in order to render a list of categories

## Test Case: Use the Products Highlights component
1. Visit the CMS at http://localhost:8080/cms/
1. Open the Channel Manager and visit the home page
1. Click on the show component button on the top-right 
1. Click and drop and the Products Highlight component in one of the available container
1. Click on the Products Highlight component to edit 
1. Regarding the Template property, select Products Highlight Carousel
1. Regarding the Carousel item 1 property, click on the related magnify lens. In the link picker modal, browse the 
products folder (on the left panel) and select the Commerce Example Product. Click Ok
1. Regarding the Carousel item 2 property, click on the related magnify lens. In the link picker modal, browse the 
products folder (on the left panel) and select the Bloomreach Example Product. Click Ok
1. Click on the Save and Close button of the Products Highlight component. Now you should be able to see the carousel 
contaning the two products.

## Test Case: Sign up
1. Visit the SITE (e.g, http://localhost:8080/site/).
1. Click on "Login" link at the top.
1. Click on "Sign up" link next to the "Sign in" button.
1. Enter your personal info in the fields and click on "Sign up" button.

## Test Case: Log in
1. Visit the SITE (e.g, http://localhost:8080/site/).
1. Click on "Login" link at the top.
1. Enter your e-mail address and password. Click on "Sign in" button.

## Test Case: Log out
1. Given you're already logged in at the SITE (e.g, http://localhost:8080/site/)
1. Click on "Log out" link at the top.

## Test Case: Manage account
1. Given you're already logged in at the SITE (e.g, http://localhost:8080/site/)
1. Select "Change password" menu item at the top to change password.
1. Select "My addresses" menu item at the top to view, add, update or delete your addresses.

## Test Case: Article page
1. Be sure that development content has been boostrapped
1. Visit the CMS at http://localhost:8080/cms/
1. Click on the content perspective on the left side bar
1. Click on the articles folder and open the article document
1. Click on the view button: click the first option in the dropdown. Channel Manager will open
1. Once the channel manager has loaded, click on the show component button on the top-right 
1. Open the left side panel and click on the Products Grid component
1. Drop the component on the "Article Main Right" container
1. Click on the component just dropped: the component dialog will show up
1. In the page size field, replace the default value with 2
1. Save and close the component configuration
1. NOTE that the channel manager tries to reload only the component: this will not work since the data defined in the
article document will not taken into account. For this reason the whole page needs to be reloaded: click on the link 
displayed in the warning message
1. When the page is completely reloaded, you will notice that the product grid is showing products based on the value of 
the first item of the tags list 

## Test Case: Article overview page
1. Be sure that development content has been boostrapped
1. Visit the CMS at http://localhost:8080/cms/
1. Click on the channels perspective on the left side bar
1. Click on the boot project channel 
1. Once the channel manager has loaded, open the left side panel 
1. Click on the Sitemap tab and click on the /articles page: Only one document will appear in the article list
1. Create a new article document (you can follow the Article Page Test Case)
1. Once finished, go back to the /articles page: two articles will show up
1. Moreover, if you defined different tags in the new article, then the tags list will contain them as well

##Test Case: Bloomreach Autosuggest API
1. Be sure that Bloomreach APIs option is enabled in the current channel
    1. To enabled Bloomreach API, visit the CMS at http://localhost:8080/cms/
    1. Click on the channels perspective on the left side bar
    1. Click on the Starter Store Boot channel
    1. Open on the Channel option (on the top left) and click on Settings
    1. If not selected, enable Bloomreach APIs
    1. Save and Publish the channel settings
1. Visit the site at http://localhost:8080/site/
1. On the top right you will find a search box
1. Type the word 'chair' in the related text field 
1. A new dropdown will appear, containing both suggestions and product
    1. If you click on a suggestions, you will be redirected to the search result page related to that displayed query
    1. If you click on a product, you will be redirected to the product detail page
    
##Test Case: Bloomreach More Like This (MLT) component
1. Be sure that Bloomreach APIs option is enabled in the current channel
1. To enabled Bloomreach API, visit the CMS at http://localhost:8080/cms/
1. Click on the channels perspective on the left side bar
1. Click on the Starter Store Boot channel
1. Open on the Channel option (on the top left) and click on Settings
1. If not selected, enable Bloomreach APIs
1. Moreover, be sure the the Pixel is properly configured and the option "Disabled in Preview" is not checked
1. Save and Publish the channel settings
1. Open the left side panel and click on the components option
1. Search for the More Like This component, click on the component end drop in on of the container
1. Click on the (empty!) component just dropped in the container
1. Once the component parameter dialog is open, fill the Product Id field (e.g 10777) and save and close the component
configuration
1. Once the dialog is closed, a set of products will show up

##Test Case: Bloomreach Just For you component
1. Be sure that Bloomreach APIs option is enabled in the current channel
1. To enabled Bloomreach API, visit the CMS at http://localhost:8080/cms/
1. Click on the channels perspective on the left side bar
1. Click on the Starter Store Boot channel
1. Open on the Channel option (on the top left) and click on Settings
1. If not selected, enable Bloomreach APIs
1. Moreover, be sure the the Pixel is properly configured and the option "Disabled in Preview" is not checked
1. Save and Publish the channel settings
1. Open the left side panel and click on the components option
1. Search for the Just For You component, click on the component end drop in on of the container
1. Once the component is dropped, a set of product should appear in the container: the set of products returned depends
on the br_uid_2 cookie set by the pixel component 

##Test Case: Create a Flexible landing page
1. Visit the CMS at http://localhost:8080/cms/
1. Open the Channel Manager
1. Click on the Page button on the top left: once the drop down is open, click on New
1. Type a page title and as part of the Page Template param select be sure that Flexible Page is selected
1. Click on Create
1. Once the created page shows up, click on the show components icon (top right)
1. A bunch of container will show up: drop any component on one of this component, trying to place items as needed
1. Once finished, publish all the changes and visit the same page in /site

