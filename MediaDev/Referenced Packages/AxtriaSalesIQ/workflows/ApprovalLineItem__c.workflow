<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Change_Request_Status</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Change Request Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Request__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Status_Flag</fullName>
        <field>Status_Flag__c</field>
        <formula>If( Text(Approval_Status__c)=&apos;Pending&apos;,0,if(Text(Approval_Status__c)=&apos;Approved&apos;,1,if(Text(Approval_Status__c)=&apos;Rejected&apos;,-100,-1)))</formula>
        <name>Change Status Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Status_Flag_to_10</fullName>
        <field>Status_Flag__c</field>
        <formula>-10</formula>
        <name>Change Status Flag to -10</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Status_to_Pending</fullName>
        <field>Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Change Status to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Request__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Status_to_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Change Status to Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>Request__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_Flag_to_0</fullName>
        <field>Status_Flag__c</field>
        <formula>0</formula>
        <name>Set Status Flag to 0</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_Flag_to_1</fullName>
        <field>Status_Flag__c</field>
        <formula>-1</formula>
        <name>Set Status Flag to -1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_Flag_to_100</fullName>
        <field>Status_Flag__c</field>
        <formula>-100</formula>
        <name>Set Status Flag to -100</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Status_Flag_to_One</fullName>
        <field>Status_Flag__c</field>
        <formula>1</formula>
        <name>Set Status Flag to 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Status Flag to -1</fullName>
        <actions>
            <name>Set_Status_Flag_to_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ApprovalLineItem__c.Approval_Status__c</field>
            <operation>equals</operation>
            <value>Not Escalated</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Status Flag to -100</fullName>
        <actions>
            <name>Set_Status_Flag_to_100</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ApprovalLineItem__c.Approval_Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Status Flag to 0</fullName>
        <actions>
            <name>Set_Status_Flag_to_0</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ApprovalLineItem__c.Approval_Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Status Flag to 1</fullName>
        <actions>
            <name>Set_Status_Flag_to_One</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ApprovalLineItem__c.Approval_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
