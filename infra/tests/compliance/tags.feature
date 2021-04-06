Feature: Ensure that all resources are tagged  
    
    Scenario: Ensure all resources have tags
        Given I have resource that supports tags defined
        Then it must contain tags
