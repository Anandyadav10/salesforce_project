@IsTest
private class ShowroomControllerTest {
    @IsTest
    static void dashboardCountsDoesNotFail() {
        Test.startTest();
        Map<String,Integer> counts = ShowroomController.getDashboardCounts();
        Test.stopTest();
        System.assertNotEquals(null, counts);
    }

    @IsTest
    static void accountModuleCanBeDescribedAndSearched() {
        Account sample = new Account(
            Name = 'Showroom Search Test',
            Phone = '555-0100',
            Website = 'https://example.com'
        );
        insert sample;

        Test.startTest();
        ShowroomController.ModuleInfo module = ShowroomController.describeModule('accounts');
        ShowroomController.PageData page = ShowroomController.getRecords(
            'accounts', 'Showroom Search', 0, -1
        );
        Test.stopTest();

        System.assertEquals('Account', module.objectApiName);
        System.assert(!module.fields.isEmpty());
        System.assertEquals(1, page.total);
        System.assertEquals(sample.Id, (Id)page.records[0].get('Id'));
    }

    @IsTest
    static void accountRecordsCanBeCreatedUpdatedAndDeleted() {
        Map<String,Object> values = new Map<String,Object>{
            'Name' => 'Showroom CRUD Test',
            'Phone' => '555-0101',
            'Website' => '',
            'NumberOfEmployees' => '12',
            'AnnualRevenue' => '12500.50',
            'Unknown_Field__c' => 'ignored'
        };

        Test.startTest();
        Id accountId = ShowroomController.saveRecord('accounts', values, null);
        ShowroomController.saveRecord(
            'accounts', new Map<String,Object>{'Phone' => '555-0102'}, accountId
        );
        Account updated = [SELECT Phone, NumberOfEmployees, AnnualRevenue FROM Account WHERE Id = :accountId];
        ShowroomController.deleteRecord('accounts', accountId);
        Test.stopTest();

        System.assertEquals('555-0102', updated.Phone);
        System.assertEquals(12, updated.NumberOfEmployees);
        System.assertEquals(Decimal.valueOf('12500.50'), updated.AnnualRevenue);
        System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Id = :accountId]);
    }

    @IsTest
    static void unsupportedModuleThrows() {
        Boolean didThrow = false;
        try {
            ShowroomController.describeModule('doesNotExist');
        } catch (AuraHandledException e) {
            didThrow = true;
        }
        System.assert(didThrow, 'Expected an unsupported-module exception');
    }
}
