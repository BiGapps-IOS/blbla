//
//  Vc1.h
//  klaster
//
//  Created by Menny Alterscu on 12/4/16.
//  Copyright © 2016 Menny Alterscu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "GClusterManager.h"

#import "Spot.h"
#import "NonHierarchicalDistanceBasedAlgorithm.h"
#import "GDefaultClusterRenderer.h"
#import "AW_Navigate.h"
#import "DataPuller.h"
#import "MennyDataSourceAutoComlete.h"
#import "KLCPopup.h"
#import "PTEHorizontalTableView.h"

@interface Vc1 : UIViewController <AW_NavigateDelegate,DataPullerDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,MennyDataSourceAutoComlete,PTETableViewDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *btnFindme;
- (IBAction)btnFindmeTapped:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEditAddress;
- (IBAction)btnEditAddressTapped:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;

@property (strong, nonatomic) AW_Navigate* locationManager;
@property (strong, nonatomic)  GMSMarker *markerU;



@property(strong,nonatomic) NSMutableArray* instaPinsArray;

@property(strong,nonatomic) NSMutableArray* clusteredPinsArray;

@property (weak, nonatomic) IBOutlet UITextField *txtSerch;

@property (weak, nonatomic) IBOutlet UIImageView *ivEmptyPin;

@property (weak, nonatomic) IBOutlet UITextField *txtSecod;



////AOUTO COMPLETE CATREING

@property(strong, nonatomic)NSString* languageFromText;

@property (nonatomic, strong) NSMutableArray* dataSource;

@property (strong ,nonatomic) NSMutableDictionary* addressSearchParamsDict;

@property(strong, nonatomic)NSString* defaultAddressString;

@property(strong, nonatomic)NSString* main_Search_type;

@property(strong, nonatomic)NSString* main_Search_typeTemp;

@property(strong, nonatomic)NSString* main_Search_textTemp;


@property (nonatomic, strong) NSString* place_Id_To_send;

@property(strong, nonatomic) NSString* noFilterString;

@property(strong, nonatomic)NSString* takenPlaceID;

@property (nonatomic, strong) NSString* addressText;


@property (weak, nonatomic) IBOutlet UIView *viewDrop;
@property (weak, nonatomic) IBOutlet UITableView *tblDrop;


@property (strong,nonatomic) NSMutableDictionary *locationTocheck;


@property (nonatomic, strong) MennyDataSourceAutoComlete *autoCompleterarry;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sig;
- (IBAction)sigChanged:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UIView *vewiDrop2;

- (IBAction)btnFindMe:(UIButton *)sender;

//
//@property (strong,nonatomic) UsersTablePop *usersPop;
//@property (strong, nonatomic) KLCPopup *pop;
@property (strong, nonatomic) IBOutlet UIView *uservcpop;
- (IBAction)btnclosetable:(UIButton *)sender;

@end
