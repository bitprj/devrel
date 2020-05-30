---
name: Content Development Proposal
about: First steps to creating a plan for content dev.
title: "[Content Dev Proposal] {{Title}} {{IMC Name}}"
labels: IMC
assignees: shreyagupta98

---

# Content Development Proposal Issue

# 📅 Due: {{Insert}}
>The DRI for this issue is the **Content Developer**. They will be responsible for keeping this issue up to date at all times.

>**FOR IMCs**: Add project manager and content developer as assignees

>Add this issue into the corresponding IMC Project

>**FORMAT:** Add blog/video/webinar labels

**[Step-By-Step Technical Blog Guide](https://hq.bitproject.org/how-to-write-a-technical-blog/)**

### :dancer: Before starting
> [Blog tracker](https://airtable.com/shrDBBOFqn5c7SlBh)
- [ ] [Submit blog choice on airtable](https://airtable.com/shrshp0d9sruL7l9J)

### :pushpin: Step 1: Proposal
📅**{{Due_Date}}**
- [ ] Complete [proposal template](https://github.com/bitprj/devrel/blob/master/contentdevproposal.md)
- [ ] [Compete Resources Request Form](https://airtable.com/shrYEJufxRzm97jha)
- [ ] Open Tutorial QA Issue
- [ ] Submit Proposal
<details><summary><b>How to: Submit Proposal</b></summary>
    
    - Create branch called #{{insert-blog-title}}

    - Fork the bitprj/devrel repo
    
    - Create a file in the following folder: bitprj/devrel/{{imc_topic}}/{{imc_name}}/{{blog_title}}/proposal.md
    
    - Commit + Push proposal.md
    
    - Create a pull request to merge into the #{{insert-blog-title}} branch on bitprj/devrel
    
    - Assign your PM to the pull request
</details>

- [How to fork a repo video](https://app.getguru.com/card/ijjKGAyT/How-to-Fork-a-Repo-Do-a-Pull-Request)

### :pushpin: Step 2: Testing Code
📅**{{Due_Date}}**
- [ ] Tested run code to check for completion

### :pushpin: Step 3: Submitting Code Deliverables
📅**{{Due_Date}}**
- [ ] Submit Code Deliverables
<details><summary><b>How to: Submit Code Deliverables</b></summary>
    - Fork the bitprj/devrel repo
    
    - Upload Finished Code on CodeSandbox
    
    - Check that all code is commented well
    
    - Link CodeSandbox in comments of this issue
    
    - Commit + Push starter code into your pertinent folder under /starter and solution code under /solution
    
    - Create a pull request to merge into the #{{insert-blog-title}} branch on bitprj/devrel
    
    - Assign your PM to the pull request
</details>

### :pushpin: Step 4: Written Deliverables
- [ ] Submit Written Deliverables

<details><summary><b>How to: Submit Written Deliverables</b></summary>
    - Fork the bitprj/devrel repo
    
    - Commit + Push written content (step-by-step blog tutorial of code) under blog.md within the pertinent folder
    
    - Create a pull request to merge into the #{{insert-blog-title}} branch on bitprj/devrel
    
    - Assign your PM to the pull request
</details>

### :pushpin: Step 5: QA 
📅**{{Due_Date}}**
- [ ] Presented blog draft and code on Loom Video
- [ ] Send Loom and Collect feedback from QA and PM

📅**{{Due_Date}}**
- [ ] Finalize blog based on QA feedback

<details>
<summary><b>Merging to Master</b></summary>

    - Open a Pull Request to Merge #{{insert-blog-title}} to #master
    
    - Assign QA Specialist to Pull Request
    
    - Assign Writing Specialist to Pull Request
</details>
