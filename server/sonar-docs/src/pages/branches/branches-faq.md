---
title: Branch FAQ
url: /branches/branches-faq/
---

_Branch analysis is available as part of [Developer Edition](https://redirect.sonarsource.com/editions/developer.html) and [above](https://www.sonarsource.com/plans-and-pricing/)._

## How long are branches retained?  
Branches will be deleted automatically when they are inactive according to your settings at [Administration > Configuration > General Settings > Housekeeping > Number of days before deleting inactive branches](/#sonarqube-admin#/admin/settings?category=housekeeping) except for branches you have set to be kept when inactive. These branches are kept until you delete them manually at the project level at **Administration > Branches & Pull Requests**. See the [Branches Analysis](/branches/overview/) for more information on keeping inactive branches.

## Does my project need to be stored in an SCM like Git or SVN?  
No, you don't need to be connected to a SCM. But if you use Git or SVN we can better track the new files on short-lived branches and so better report new issues on the files that really changed during the life of the short-lived branch.

## What if I mark an Issue "Won't Fix" or "False-Positive" in a branch?
It will be replicated as such when creating a Pull Request and merging the Pull Request into the master branch.

## Can I manually delete a branch?  
You can delete a branch in the **Branches** tab at **Project Settings > Branches and Pull Requests**.

## Does the payload of the Webhook include branch information?  
Yes, an extra node called "branch" is added to the payload.

## When are Webhooks called?  
When the computation of the background task is done for a given branch but also when an issue is updated on a short-lived branch.

## What is the impact on my LOCs consumption vs my license?  
The LOC of your largest branch are counted toward your license limit. All other branches are ignored.  
