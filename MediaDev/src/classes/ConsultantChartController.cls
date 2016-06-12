public class ConsultantChartController {
	
	private final static Integer NUM_REGIONS = 50; // Will be trimmed down post-processing
	private final static Time TIME_STUB = Time.newInstance(0, 0, 0, 1);
    private final static String RECORD_TYPE_NAME = 'NADA';
    
    private String rtId = '';

    public ConsultantChartController() {	
    	System.debug('In Chart Constructor');
    	
    	// Get record type id for filtering later
        List<RecordType> recordTypes = [select Id, Name from RecordType where Name = :RECORD_TYPE_NAME and SobjectType = 'Action_Plan__c'];
        if (recordTypes.size() > 0) {
            System.debug('We got a record type, ' + recordTypes[0].Id);
            rtId = recordTypes[0].Id;
        } else {
            System.debug('No record types for ' + RECORD_TYPE_NAME);
        }
    }
	
    // Return a list of data points for a chart
    public List<Data> getConsultantSummaryData() {
        return ConsultantChartController.getChartConsultantSummaryData();
    }
    
    public List<Data> getCountsPerRegion() {
    	return ConsultantChartController.getChartCountsPerRegion();
    }
    
    public List<Data> getTotalSummaries() {
    	return ConsultantChartController.getChartTotalSummaries();
    }
    
    public List<Data> getAreasOfFocus() {
    	return ConsultantChartController.getChartAreasOfFocus();
    }
    
    public List<Data> getFrontEndFundamentals() {
    	return ConsultantChartController.getChartFrontEndFundamentals();
    }
    
    public List<Data> getReportsReviewed() {
    	return ConsultantChartController.getChartReportsReviewed();
    }
    
    public List<Data> getRequestedInfo() {
    	return ConsultantChartController.getChartRequestedInfo();
    }
    
    public List<Data> getNewAtATCKBB() {
    	return ConsultantChartController.getChartNewAtATCKBB();
    }
    
    // The actual chart data; needs to be static to be
    // called by a @RemoteAction method
    public static List<Data> getChartConsultantSummaryData() {
        
        Show_Consultant__c[] showConsultants = [SELECT Name from Show_Consultant__c ORDER BY Name];
        
        Map<String, Data> consultantMap = new Map<String, Data>();
        for (Show_Consultant__c consultant: showConsultants) {
        	consultantMap.put(consultant.Name, new Data(consultant.Name));
        }
        
        List<Action_Plan__c> actionPlans = getActionPlans(-7);
        
        for (Action_Plan__c actionPlan : actionPlans) {
        	if (actionPlan.Trade_Show_Consultant_s__c == null) {
        		System.debug('It\'s null, wha?');
        	} else {
              	List<String> tscs = actionPlan.Trade_Show_Consultant_s__c.split(';');
             	System.debug('Name is ' + actionPlan.Name + ', split is ' + tscs);
             	
             	for (String tsc : tscs) {
             		System.debug(' about to do ' + tsc);
             		Data cData = consultantMap.get(tsc);
             		System.debug('data is ' + cData);
             		if (cData != null) {
             			updateDailyData(cData, actionPlan);
             		}
             	}
        	}
        }
        
        List<Data> data = new List<Data>();
        List<String> names = new List<String>();
        names.addAll(consultantMap.keySet());
        names.sort();
        System.debug('Names is ' + names);
        
        for (String name : names) {
        	Data value = consultantMap.get(name);
        	if (value != null) {
        	    data.add(value);
        	}
        }
        
        return data;
    }
    
    public static List<Data> getChartCountsPerRegion() {
        List<Action_Plan__c> actionPlans = getActionPlans(-7);
        
        List<Data> dataCandidates =  new List<Data>();
        dataCandidates.add(new Data('-'));
        for (Integer i = 1; i <= NUM_REGIONS; i++) {
            dataCandidates.add(new Data(i.format()));
        }
        
        
        for (Action_Plan__c actionPlan : actionPlans) {
            Integer r = 0;
            System.debug('Region text is ' + actionPlan.Region__c);
            try {
                r = Integer.valueOf(actionPlan.Region__c);
                if (r < 0 || r > NUM_REGIONS) {
                    r = 0;
                }
            } catch (Exception e) {
                r = 0;
            }
            updateDailyData(dataCandidates[r], actionPlan);
        }
        
        List<Data> data = new List<Data>();
        for (Integer i = 0; i <= NUM_REGIONS; i++) { // 0 gets the -
            if (dataCandidates[i].data1 > 0 ||
                dataCandidates[i].data2 > 0 ||
                dataCandidates[i].data3 > 0 ||
                dataCandidates[i].data4 > 0) {
            	data.add(dataCandidates[i]);
            }
        }
        
        return data;
    } 
    
    public static List<Data> getChartTotalSummaries() {
        List<Action_Plan__c> actionPlans = getActionPlans(-7);
        
    	List<Data> data =  new List<Data>();
    	data.add(new Data('Paying Dealers M-Th'));
    	data.add(new Data('Prospects M-Th'));
    	data.add(new Data('Paying Dealers Fr'));
    	data.add(new Data('Prospects Fr'));
    	data.add(new Data('Paying Dealers Sa'));
    	data.add(new Data('Prospects Sa'));
    	data.add(new Data('Paying Dealers Su'));
    	data.add(new Data('Prospects Su'));
        
        for (Action_Plan__c actionPlan : actionPlans) {
            /* Get the day of week in a parsable format. */
            /* For debugging, discussion date on a past date range. */
            // Datetime apdt = Datetime.newInstance(actionPlan.Discussion_Date__c, TIME_STUB);
            // String dayOfWeek = apdt.format('EEE');
            // System.debug('date is ' + actionPlan.Discussion_Date__c + ', ' + dayOfWeek);
            /* Running, last date time Action Plan was modified. */
            String dayOfWeek = actionPlan.LastModifiedDate.format('EEE');
            System.debug('date is ' + actionPlan.LastModifiedDate + ', ' + dayOfWeek);
        	if (actionPlan.Account__c != null) {
                if (dayOfWeek.equals('Fri')) {
            	    updateHourlyData(data[2], actionPlan);
                } else if (dayOfWeek.equals('Sat')) {
            	    updateHourlyData(data[4], actionPlan);
                } else if (dayOfWeek.equals('Sun')) {
            	    updateHourlyData(data[6], actionPlan);
                } else { /* It's Monday - Thursday. */
            	    updateHourlyData(data[0], actionPlan);
                }
            } else {
                if (dayOfWeek.equals('Fri')) {
                    updateHourlyData(data[3], actionPlan);
                } else if (dayOfWeek.equals('Sat')) {
                    updateHourlyData(data[5], actionPlan);
                } else if (dayOfWeek.equals('Sun')) {
                    updateHourlyData(data[7], actionPlan);
                } else { /* It's Monday - Thursday. */
                    updateHourlyData(data[1], actionPlan);
                }
        	}
        }
        
        return data;
    } 
    
    public static List<Data> getChartAreasOfFocus() {
        List<Action_Plan__c> actionPlans = getActionPlans(-7);
        
    	List<Data> data =  new List<Data>();
    	data.add(new Data('Front End Fundamentals of Top Dealerships'));
    	data.add(new Data('How Your Dealership is Doing'));
    	data.add(new Data('Learn How Consumers Really Shop'));
    	data.add(new Data('New at AutoTrader.com/Kelley Blue Book'));
        
        for (Action_Plan__c actionPlan : actionPlans) {
        	if (actionPlan.Front_End_Fundamentals_of_Top_Dealership__c) {
        		updateDailyData(data[0], actionPlan);
        	}
        	if (actionPlan.How_Your_Dealership_is_Doing__c) {
        		updateDailyData(data[1], actionPlan);
        	}
        	if (actionPlan.Learn_How_Consumers_Really_Shop__c) {
        		updateDailyData(data[2], actionPlan);
        	}
        	if (actionPlan.What_s_New_at_AutoTrader_Group__c) {
        		updateDailyData(data[3], actionPlan);
        	}
        }
        
        return data;
    } 
    
    public static List<Data> getChartFrontEndFundamentals() {
        List<Action_Plan__c> actionPlans = getActionPlans(-7);
        
    	List<Data> data =  new List<Data>();
    	data.add(new Data('Acquisition Process'));
    	data.add(new Data('Customer Handling'));
    	data.add(new Data('Descriptions'));
    	data.add(new Data('Photos'));
    	data.add(new Data('Pricing'));
    	data.add(new Data('Reconditioning'));
    	data.add(new Data('Transportation'));
    	data.add(new Data('Vehicle Selection'));
        
        for (Action_Plan__c actionPlan : actionPlans) {
        	if (actionPlan.Acquisition_Process__c) {
        		updateDailyData(data[0], actionPlan);
        	}
        	if (actionPlan.Customer_Handling__c) {
        		updateDailyData(data[1], actionPlan);
        	}
        	if (actionPlan.Descriptions__c) {
        		updateDailyData(data[2], actionPlan);
        	}
        	if (actionPlan.Photos__c) {
        		updateDailyData(data[3], actionPlan);
        	}
        	if (actionPlan.Pricing__c) {
        		updateDailyData(data[4], actionPlan);
        	}
        	if (actionPlan.Reconditioning__c) {
        		updateDailyData(data[5], actionPlan);
        	}
        	if (actionPlan.Transportation__c) {
        		updateDailyData(data[6], actionPlan);
        	}
        	if (actionPlan.Vehicle_Selection__c) {
        		updateDailyData(data[7], actionPlan);
        	}
        }
        
        return data;
    } 
    
    public static List<Data> getChartReportsReviewed() {
        List<Action_Plan__c> actionPlans = getActionPlans(-7);
        
        List<Data> data =  new List<Data>();
        data.add(new Data('Dealer Site'));
        data.add(new Data('Local Market Sheets'));
        data.add(new Data('New Scorecard'));
        data.add(new Data('Other'));
        data.add(new Data('Trade In Marketplace'));
        data.add(new Data('Tune Up Report'));
        data.add(new Data('Used Scorecard'));
        
        for (Action_Plan__c actionPlan : actionPlans) {
            if (actionPlan.Dealer_Site__c) {
                updateDailyData(data[0], actionPlan);
            }
            if (actionPlan.Local_Market_Sheets__c) {
                updateDailyData(data[1], actionPlan);
            }
            if (actionPlan.New_Scorecard__c) {
                updateDailyData(data[2], actionPlan);
            }
            if (actionPlan.Other_Reports_Reviewed__c) {
                updateDailyData(data[3], actionPlan);
            }
            if (actionPlan.Trade_In_Marketplace_RR__c) {
                updateDailyData(data[4], actionPlan);
            }
            if (actionPlan.Tune_Up_Report__c) {
                updateDailyData(data[5], actionPlan);
            }
            if (actionPlan.Used_Scorecard__c) {
                updateDailyData(data[6], actionPlan);
            }
        }
        
        return data;
    } 
    
    public static List<Data> getChartRequestedInfo() {
        List<Action_Plan__c> actionPlans = getActionPlans(-7);
        
        List<Data> data =  new List<Data>();
        data.add(new Data('Haystak'));
        data.add(new Data('HomeNet'));
        data.add(new Data('KBB'));
        data.add(new Data('MakeMyDeal'));
        data.add(new Data('Manheim'));
        data.add(new Data('Other'));
        data.add(new Data('Trade-In Marketplace'));
        data.add(new Data('vAuto'));
        data.add(new Data('Vin Solutions'));
        
        for (Action_Plan__c actionPlan : actionPlans) {
            if (actionPlan.Haystak__c) {
                updateDailyData(data[0], actionPlan);
            }
            if (actionPlan.HomeNet__c) {
                updateDailyData(data[1], actionPlan);
            }
            if (actionPlan.KBB__c) {
                updateDailyData(data[2], actionPlan);
            }
            if (actionPlan.Make_My_Deal__c) {
                updateDailyData(data[3], actionPlan);
            }
            if (actionPlan.Manheim__c) {
                updateDailyData(data[4], actionPlan);
            }
            if (actionPlan.Other_Requested_Info__c) {
                updateDailyData(data[5], actionPlan);
            }
            if (actionPlan.Trade_In_Marketplace_RI__c) {
                updateDailyData(data[6], actionPlan);
            }
            if (actionPlan.vAuto__c) {
                updateDailyData(data[7], actionPlan);
            }
            if (actionPlan.Vin_Solutions__c) {
                updateDailyData(data[8], actionPlan);
            }
        }
        
        return data;
    } 
    
    public static List<Data> getChartNewAtATCKBB() {
        List<Action_Plan__c> actionPlans = getActionPlans(-7);
        
        List<Data> data =  new List<Data>();
        data.add(new Data('ListingLogic'));
        data.add(new Data('Other'));
        data.add(new Data('SEM'));
        
        for (Action_Plan__c actionPlan : actionPlans) {
            if (actionPlan.Listing_Logic__c) {
                updateDailyData(data[0], actionPlan);
            }
            if (actionPlan.Other_What_s_New__c) {
                updateDailyData(data[1], actionPlan);
            }
            if (actionPlan.SEM__c) {
                updateDailyData(data[2], actionPlan);
            }
        }
        
        return data;
    } 
    
    private static List<Action_Plan__c> getActionPlans(Integer daysPrevious) {
    	Date d = system.today().addDays(daysPrevious);
        
        List<Action_Plan__c> actionPlans = null;
            actionPlans = 
        [select Id, Name, Trade_Show_Consultant_s__c, LastModifiedDate, Discussion_Date__c,
        
        Account__c, 
        
        Region__c,
        
        Front_End_Fundamentals_of_Top_Dealership__c, How_Your_Dealership_is_Doing__c,
        Learn_How_Consumers_Really_Shop__c, What_s_New_at_AutoTrader_Group__c,
        
        Acquisition_Process__c, Customer_Handling__c, Descriptions__c, Photos__c, 
        Pricing__c, Reconditioning__c, Transportation__c, Vehicle_Selection__c,
        
        Dealer_Site__c, Local_Market_Sheets__c, New_Scorecard__c, Other_Reports_Reviewed__c,
        Trade_In_Marketplace_RR__c, Tune_Up_Report__c, Used_Scorecard__c,
        
        KBB__c, Trade_In_Marketplace_RI__c, Haystak__c,
        HomeNet__c, vAuto__c, Vin_Solutions__c, Manheim__c, Make_My_Deal__c, Other_Requested_Info__c,
        
        Listing_Logic__c, SEM__c, Other_What_s_New__c
         
        from Action_Plan__c 
        where
        RecordTypeId in (select Id from RecordType where Name = 'NADA' and SobjectType = 'Action_Plan__c')
        and
        Discussion_Date__c >= :d];
          
        System.debug('Number of Action Plans is ' + actionPlans.size());
        
    	return actionPlans;
    }
    
    private static void updateDailyData(Data cData, Action_Plan__C actionPlan) {
        /* Get the day of week in a parsable format. */
        /* For debugging, discussion date on a past date range. */
        // Datetime apdt = Datetime.newInstance(actionPlan.Discussion_Date__c, TIME_STUB);
        // String dayOfWeek = apdt.format('EEE');
        // System.debug('date is ' + actionPlan.Discussion_Date__c + ', ' + dayOfWeek);
        /* Running, last date time Action Plan was modified. */
        String dayOfWeek = actionPlan.LastModifiedDate.format('EEE');
    	
    	if (dayOfWeek.equals('Fri')) {
    		cData.data2 = cData.data2 + 1;
    	} else if (dayOfWeek.equals('Sat')) {
    		cData.data3 = cData.data3 + 1;
    	} else if (dayOfWeek.equals('Sun')) {
    		cData.data4 = cData.data4 + 1;
    	} else { /* It's Monday - Thursday. */
    		cData.data1 = cData.data1 + 1;
    	}
    }
    
    private static void updateHourlyData(Data cData, Action_Plan__C actionPlan) {
    	Integer hour = actionPlan.LastModifiedDate.hour();
    	
    	if (hour <= 13) {
    		cData.data1 = cData.data1 + 1;
    	} else if (hour <= 14) {
    		cData.data2 = cData.data2 + 1;
    	} else if (hour <= 16) {
    		cData.data3 = cData.data3 + 1;
    	} else {
    		cData.data4 = cData.data4 + 1;
    	}
    }
    
    // Wrapper class
    public class Data {
        public String name { get; set; }
        public Integer data1 { get; set; }
        public Integer data2 { get; set; }
        public Integer data3 { get; set; }
        public Integer data4 { get; set; }
        
        public Data(String name) {
            this(name, 0, 0, 0, 0);
        }
        
        public Data(String name, Integer data1) {
            this(name, data1, 0, 0, 0);
        }
        
        public Data(String name, Integer data1, Integer data2, Integer data3, Integer data4) {
            this.name = name;
            this.data1 = data1;
            this.data2 = data2;
            this.data3 = data3;
            this.data4 = data4;
        }
    }
}