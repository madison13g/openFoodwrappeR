# DATA 534 Group Project
## Wrap data API!
The goal of this group project is to develop a R/Python package wrapping a [RESTful API](https://www.techtarget.com/searchapparchitecture/definition/RESTful-API)

This is a group project and each group get to choose the API. Each group are responsible for: 
1. the design and implementation of the package; 
2. the completeness and readibility of the documentations and of the [vignettes](https://www.gastonsanchez.com/packyourcode/vignettes.html); 
3. the test coverage of the code

You will work as a group. However, this is not a democracy and you will have to report to me. To do that, I <strong>expect</strong> you to: 
1. commit and push often (e.g., anytime you write some meaningful piece of code or documentation),
2. keep a daily project notebook in your repo. We (the TA and I) might check the notebooks.

**Step 1** Group formation (max 3 people)

**Step 2** Set up a group repo in Github where your package will live, and work on it through pull requests (forks or branches, your choices) and NOT through direct commits. You will have a link to that repo and your project notebook in your own repo.

**Step 3** Submit the project proposal by the deadline. This will be a pdf document describing what API your group is going to work on, and what is, roughly speaking, your intended outcome. I may dissuade you from attempting something too ambitious (or in the really <em>rare</em> case that you are attempting something way too easy) but you are the boss. In general, projects fail because they are too ambitious, not because they are too easy.

### Software requirements
The goal of the package is to wrap into a set of R/Python functions a web REST API and offer a package for others to use those functions. The functions offered by the package should also take care of the minimum wrangling necessary to output the data in a viable format (that is, not as a raw binary file, unless a raw binary file is the most appropriate data format). You choose the API and the most appropriate input / output design of your functions. Think carefully of what part of the wrangling is of general interest (i.e., most or all of the users will want to perform it, and thus should be done in the package) and what part is only relevant as an example for the vignette (i.e., is too specific to be of general interest, and thus may just end up in the vignette.)

Here are some ideas of APIs (just some almost random example):

- [Github Activity](https://developer.github.com/v3/activity/) a rather new API "Serving up the social" in Social Coding, the Activity APIs provide access to notifications, subscriptions, and timelines.
- All of these [references](https://www.programmableweb.com/category/reference/api) APIs are (probably, I did not check ALL of them) good examples
- [BC laws](https://catalogue.data.gov.bc.ca/dataset/bc-laws-api) search through the laws in BC
- [BC data apis](https://catalogue.data.gov.bc.ca/dataset?tags=API) a collection of APIs for BC data
- [GDELT](https://blog.gdeltproject.org/gdelt-geo-2-0-api-debuts) This is a rewarding, yet **tough**, one. Take a look at [leaflet](https://rstudio.github.io/leaflet/json.html) for an idea on how to use what you get back from GDELT.
- <a href="https://open.canada.ca/en/access-our-application-programming-interface-api">Canada open data</a> Another rewarding but tough one.
- <a href="https://github.com/car2go/openAPI">car2go</a> (requires <a href="https://github.com/car2go/openAPI/wiki/Access-protected-Functions-via-OAuth-1.0#registration-as-consumer">registration</a>)
- <a href="https://www.quandl.com/docs/api">Quandl</a>
- <a href="https://developer.github.com/v3/">GitHub API</a>: you can get stats about open source projects and developers, and say something interesting about them
- <a href="https://developer.lufthansa.com/docs">Lufthansa</a> 

<p>The package must be installable in Windows, Mac and Linux environments. Rare ecceptions are possibile, but you will need to extensively document and prove that you can&#39;t reasonably have your package to compile.</p>
<p>The functions in the code must be tested and documented. I'm talking not just forward facing documentation for the user, but also inline comments for developers to navigate your source code and understand it.</p>
<p>Read the <em>Best practices for API packages</em> <code>httr</code> <a href="http://httr.r-lib.org/articles/api-packages.html">vignette</a>. Do it. Read them. I do expect your package to apply to the best practices. Also, recall what you learnt in Collaborative Software Development module.</p>

<p>As a remainder:</p>

<p>At the end of this project, these packages should:</p>
<ul>
<li> have functions that should handle errors gracefully </li>
<li> be well documented using all possible documentation tools </li>
<li> have unit and integration tests </li>
<li> use continuous integration (with a passing build stamp in the README) </li>
<li> have a Software Licence that describes how you will permit others to use your work </li>
<li> have a code of conduct document that describes behavioural expectations of team interactions </li>
<li> have a contributions document that outlines how the team will work together (expected workflow practices) </li>
<li> have a Git history that demonstrates the proposed workflow in the CONTRIBUTING.md file was followed and that all group members contributed equally </li>
</ul>

You may want to find an API for which no R/Python wrapper already exists, or you find the existing one too cumbersome/too limiting.

### Docs and vignettes
Special attention will be given to assess the completeness and readibility of your documentation and vignettes. Have at a least one vignette, illustrating most if not all of your package functionality. Documentation must be readable.

And <strong>hard</strong> requirement for the vignette is that the workflow you offer should include some plotting: show me how to go from zero to graph.

### Notebook
**THIS IS AN INDIVIDUAL TASK.** Document and report daily your job in your own github repo for the assignment. There are different technology / tools to do this, but the least is a Rmarkdown document, updatated daily, with a short summary of what you did that day for the project, its role in the bigger group picture, and links to the github commits proving your efforts. It is also important to document any relevant development decision you took (e.g., &quot;I decided to use this instead of that because this reason&quot;).  </p>
<p>This is an interesting reading about dry lab notebooks: <a href="http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004385">http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004385</a> While this post illustrates how to keep one in <code>Bookdown</code> (not that yours needs to be that fancy): <a href="https://timoast.github.io/blog/2017-04-03-comp-notebook/">https://timoast.github.io/blog/2017-04-03-comp-notebook/</a> 
<p>P.S. A **hypertough** project (you should attempt this ONLY if you feel completely comfy and speedy in working with APIs and secrets and stuff) is to develop an R/Python package that uses the <a href="https://developer.github.com/v3/activity/">Github Activity</a> APIs, and some input from the user, to produce this Rmarkdown notebook we are speaking about.</p>

## Additional resources
<p>The main reference book is Hadley&#39;s &quot;R Packages&quot;: <a href="http://r-pkgs.had.co.nz/">http://r-pkgs.had.co.nz/</a><br>The best way to develop a package I&#39;ve seen so far is through <code>usethis</code>: <a href="http://usethis.r-lib.org/">http://usethis.r-lib.org/</a><br>This guide on using APIs is probably all you need to know: <a href="https://zapier.com/learn/apis/">https://zapier.com/learn/apis/</a><br>ROpenSci hosts already a ton of good R wrapper for APIs, it may be worth to take a look at some of those and get inspired: <a href="https://github.com/search?q=org%3Aropensci+api+wrapper">https://github.com/search?q=org%3Aropensci+api+wrapper</a>  </p>
