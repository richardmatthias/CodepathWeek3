//
//  MapViewController.swift
//  Yelp
//
//  Created by Langtian Qin on 2/13/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var businesses:[Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let centerLocation=CLLocation(latitude: 37.795346, longitude:  -122.392711)
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                    let country = "United States"
                    let city = "San Francisco"
                    let street = business.address
                    let address="\(country),\(city),\(street ?? "")"
                    let geocoder=CLGeocoder()
                    geocoder.geocodeAddressString(address){ (placemarks, error) in
                        if let placemarks = placemarks {
                            let coordinate = placemarks.first!.location!
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = coordinate.coordinate
                            annotation.title = business.name
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                }
            }
        }
        )
        goTo(location: centerLocation)
        /*for business in businesses{
            let country = "United States"
            let city = "San Francisco"
            let street = business.address
            let address="\(country),\(city),\(street ?? "")"
            let geocoder=CLGeocoder()
            for business in businesses{
                geocoder.geocodeAddressString(address){ (placemarks, error) in
                    if let placemarks = placemarks {
                        if placemarks.count != 0 {
                            let coordinate = placemarks.first!.location!
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = coordinate.coordinate
                            annotation.title = business.name
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                }
            }
        }*/
        // Do any additional setup after loading the view.
    }

    func goTo(location:CLLocation){
        let span=MKCoordinateSpanMake(0.1, 0.1)
        let region=MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
