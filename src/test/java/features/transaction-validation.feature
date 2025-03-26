Feature: Validate Transaction

  Background:
    * url 'http://localhost:5000'
    * header Content-Type = 'application/json'

  @ValidTransaction
  Scenario: Valid transaction with amount <= 5000 and same locations
    Given path '/validate'
    And request read('../data/valid-transaction.json')
    When method post
    Then status 200
    And match response.status == 'VALID'

  @ManualReviewAmount
  Scenario: Transaction requires manual review due to amount
    Given path '/validate'
    And request read('../data/manual-review-amount.json')
    When method post
    Then status 200
    And match response.status == 'MANUAL_REVIEW_NEEDED'

  @ManualReviewLocation
  Scenario: Transaction requires manual review due to different locations
    Given path '/validate'
    And request read('../data/manual-review-location.json')
    When method post
    Then status 200
    And match response.status == 'MANUAL_REVIEW_NEEDED'

  @RejectTransaction
  Scenario: Transaction is rejected due to amount
    Given path '/validate'
    And request read('../data/reject-transaction.json')
    When method post
    Then status 200
    And match response.status == 'REJECT'