# Master IMC Issue Templates

Week 0
---

==[IMC Proposal] {{Insert IMC Name}} [Integrated Campaign]==
---
## 🙌 Proposal for {{Insert IMC Name}}  Integrated Campaign
<--- The DRI for this issue is the President. They will be repsonsible for keeping this issue up to date at all times --->

#### President
- [ ] Open IMC Issue
- [ ] Get Project Manager (annouce in channel)

#### Project Manager
- [ ] Create #imc-[title] channel on Slack
- [ ] Make announcement on #general channel
- [ ] Build team on Slack (3-4 marketing + 3-4 devs)

Week 1
---

==[IMC Plan] {{Insert IMC Name}} [Integrated Campaign]==
---
## 🙌 Overview of {{Insert IMC Name}}  Integrated Campaign
<!-- Assign Marketing Manager to this issue -->

This is the parent epic, organizing issues for the {{Insert IMC Name}} integrated campaign, launch date {{Insert Launch Date}}. The related issues will be included below (upon rollout of the campaign) with DRIs, due dates, and labels assigned appropriately.

Please see related issues for details related to their respective purposes - this issue will be used for high level communication regarding the integrated campaign.

## 👪 Team
- {{Insert Position}}:{{Insert Person Name}} {{@ Github Username}}

## 👥 Target Audience 
- {{Link Persona Here}}

## 🔗 Relevant Links
- {{Insert IMC Plan Link Here}}
- {{Insert Webinar Plan Link Here}}
- {{Insert Webinar Slides Link Here}}
- {{insert Content Draft Link Here}}

## Key Deadlines
<!-- Determine schedule + deadlines in Week 1 -->
- [ ] 📅 {{Insert Date Here}} Merged Pull Request for IMC Plan 
- [ ] 📅 {{Insert Date Here}} Merged Pull Request for Webinar Plan + Code Deliverables into bitprj/curriculum
- [ ] 📅 {{Insert Date Here}} Merged Pull Request for Rough Draft of Content + Tested Code
- [ ] 📅 {{Insert Date Here}} Submit Rough Draft of Webinar 
- [ ] 📅 {{Insert Date Here}} Submitted draft to Writing Team for Feedback. 
- [ ] 📅 {{Insert Date Here}} Submit Finalized Draft to Design Team + Writing Team
- [ ] 📅 {{Insert Date Here}} Hold Webinar
- [ ] 📅 {{Insert Date Here}} Hold Retrospective 


### Associated Content:
#### Marketing Manager
- @user will be working on ABC {{Insert #issue link}}
- Webinar link:
#### Marketing Partners
- @user will be working on ABC {{Insert #issue link}}
#### Developers
- @user will be working on ABC {{Insert #issue link}}
#### Designers
- @user will be working on ABC {{Insert #issue link}}
#### Writers
- @user will be working on ABC {{Insert #issue link}}


==[Content Dev Proposal] {{Title}} {{IMC Name}}==
---
>The DRI for this issue is the **Content Developer**. They will be responsible for keeping this issue up to date at all times.

>**FOR IMCs**: Add project manager and content developer as assignees

>Add this issue into the corresponding IMC Project

>**FORMAT:** Add blog/video labels

**[Step-By-Step Technical Blog Guide](https://hq.bitproject.org/how-to-write-a-technical-blog/)**

### :dancer: Before starting
- [ ] [Submit blog choice on airtable](https://airtable.com/shrshp0d9sruL7l9J)

### :pushpin: STEP 1: Proposal
- [ ] Fill out proposal template
- [ ] Compete Resources Request Form ==(LINKED)==:red_circle: 
- [ ] Open Tutorial Development Issue
- [ ] Open Tutorial Quality Assurance Issue
- [ ] **Submitting Proposal**
    - Fork the bitprj/devrel repo
    - Create a folder with title of proposal in the pertinent topic folder
    - Commit + Push proposal.md
    - Create branch called #{{insert-blog-title}}
    - Create a pull request to merge into the #{{insert-blog-title}} branch on bitprj/devrel
    - Assign your PM to the pull request

### :pushpin: Step 2: Testing Code
- [ ] Tested run code to check for completion

### :pushpin: Step 3: Submitting Code Deliverables
- [ ] **Submitting Code Deliverables**
    - Fork the bitprj/devrel repo
    - Upload Finished Code on CodeSandbox
    - Check that all code is commented well
    - Link CodeSandbox to the Content Development Plan Issue
    - Commit + Push starter code into your pertinent folder under /starter and solution code under /solution
    - Create a pull request to merge into the #{{insert-blog-title}} branch on bitprj/devrel
    - Assign your PM to the pull request

### :pushpin: Step 4: Written Deliverables
- [ ] **Submit Written Deliverables**
    - Fork the bitprj/devrel repo
    - Commit + Push written content (step-by-step blog tutorial of code) under blog.md within the pertinent folder
    - Create a pull request to merge into the #{{insert-blog-title}} branch on bitprj/devrel
    - Assign your PM to the pull request

### :pushpin: Step 5: QA
- [ ] **[duedate]** Presented blog draft and code on Loom Video
- [ ] **[duedate]** Send Loom and Collect feedback from QA and PM
- [ ] **[duedate]** Finalize blog based on QA feedback
<details>
<summary><b>Merging to Master</b></summary>

    - Open a Pull Request to Merge #{{insert-blog-title}} to #master
    
    - Assign QA Specialist to Pull Request
    
    - Assign Writing Specialist to Pull Request
</details>



:red_circle: ==Resource Request {{Title}} {{IMC Name}}==
---
> The DRI for this issue is the individual developer

**[duedate for issue]** 


Rate the following from a scale of 1-5 (1=lowest)
- Experience w/ chosen subtopic: ==[1-2-3-4-5]==
- Experience w/ chosen blog title: ==[1-2-3-4-5]==
- Confidence in ability to complete blog w/o external resources ==[1-2-3-4-5]==

If you need more resources, please check off from the following list (you can add your own ideas as well)
- [ ] Interview w/ Industry Professional
[add details + explanation]
- [ ] Interview w/ Professor/Grad Student in your chosen blog's field
[add details + explanation]
- [ ] Access to paid online resources
[add details + explanation]
- [ ] Discussion with QA regarding development plan
[add details + explanation]

==IMC Growth Plan {{IMC Name}}==
---
> The DRI for this issue is the Project Manager
> This issue involves the marketing growth team

**[duedate for issue]** 
- Target audience: {{insert_answer_here}}
- Research on audience engagement: {{respond_to_all}}
    - What type of content does this audience respond well to?
    - What platforms will we use to promote this content?
    - What order should the blogs be released (schedule with Social Media team)?
    - What is the target number of attendees (range)?
    - What is the target number of people to plan on reaching out to (range)?
    - How are we going to reach this audience (contact collection, email marketing strategy)?
- [ ] Confirm all marketing campaign plans are scheduled
- [ ] IMC Growth Plan issue reviewed by directors

---

Week 2
---

==[Webinar Slidedeck] {{IMC Name}}==
---
> The DRI for this issue is the Project Manager

- [ ] **[duedate]** Secured professional speakers/guest hosts
- [ ] **[duedate]** Interviewed all speakers to determine talking points
- [ ] **[duedate]** Outlined webinar direction in slidedeck
- [ ] **[duedate]** Developing all blogs related to webinar
- [ ] **[duedate]** Code testing started for **all** blogs

==Tutorial Quality Assurance {{Title}} {{IMC Name}}==
---
> The DRI for this issue is the QA

**Objective:** Keep a high quality of code example 

:fire: QA for {{insert_blog_name}} {{link_issue_here}}
- [ ] Provide feedback during planning stage
- [ ] Provide feedback in the form of code reviews as often as necessary
    - [ ] Refer to [suggested questions doc](https://hackmd.io/@9p8S2u5RRPWZbntOMX167w/BJiXazoqI/edit) to give constructive feedback
- [ ] Refer project to other QAs if you're not comfortable with publication
- [ ] Approve for publishing

## Week 3

> Below are the instructions on how to create collapsible sections

# ==A collapsible section containing markdown==
<details>
  <summary>Click to expand!</summary>
  
  ## Heading
  1. A numbered
  2. list
     * With some
     * Sub bullets
</details>

# A collapsible section containing code
<details>
  <summary>Click to expand!</summary>
  
- [ ] **[duedate]** Tested run code to check for completion
- [ ] **[duedate]** Learned code
- [ ] **[duedate]** Provided feedback on code comments + style
- [ ] **[duedate]** Scheduled 2:1 meeting w/ QA
- [ ] **[duedate]** Created step-by-step blog tutorial
- [ ] **[duedate]** Presented blog draft and code to QA
- [ ] **[duedate]** Collected feedback from QA
- [ ] **[duedate]** Finalized blog based on QA feedback
</details>

# How to structure
```
# A collapsible section with markdown
<details>
  <summary>Click to expand!</summary>
  
  ## Heading
  1. A numbered
  2. list
     * With some
     * Sub bullets
</details>
```
**NB:** Make sure you have an **empty line** after the closing `</summary>` tag, otherwise the markdown/code blocks won't show correctly.

**NB**: Make sure you have an **empty line** after the closing `</details>` tag if you have multiple collapsible sections.
