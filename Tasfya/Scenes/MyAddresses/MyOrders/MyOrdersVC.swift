//
//  MyOrdersVC.swift
//  Tasfya
//
//  Created by Amr on 06/09/2021.
//

import UIKit

class MyOrdersVC: BaseVC {
    let baseUrl = "http://yousry.drayman.co/"
    var customerId : Int?
    var orderModel : AllOrder? {
        didSet {
            DispatchQueue.main.async {
                self.OrderTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var OrderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCustomerId()
        OrderTableView.delegate = self
        OrderTableView.dataSource = self
//        self.navigationItem.setLeftBarButton(nil, animated: false)
        register()

    }
    
    func register() {
        OrderTableView.register(UINib(nibName: "OrdersCell", bundle: nil), forCellReuseIdentifier: "OrdersCell")
    }
    func getCustomerId(){
        guard let data = UserLoginCache.get()?.data else { return }
        for userdata in data {
            customerId = Int(userdata.customersID)
        }
        callPostApi()
    }
    
    func callPostApi(){
        let languagehandler = LanguageHandler()
        let parameter = ["language_id":languagehandler.languageId ,"customers_id":customerId]
        let service = Service.init(baseUrl: baseUrl)
        service.getAllOrder(endPoint: "getOrders",parameter: parameter as [String : Any],  model: "AllOrder")
        service.completionHandler{[weak self] (category, status, message) in

            if status {
                guard let  dataModel = category else {return}
                self?.orderModel = dataModel as? AllOrder
             print(self?.orderModel  ?? 0)
            }
            else{
               print(message)
            }
        }
    }
   
}

extension MyOrdersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersCell", for: indexPath) as! OrdersCell
        cell.callBack = { [weak self] in
            self?.navigationController?.pushViewController(OrderDetailsVC(), animated: true)
        }
        cell.orderIDLbl.text = orderModel?.data?[indexPath.row].ordersID
        cell.orderStatusLbl.text = orderModel?.data?[indexPath.row].ordersStatus
        cell.numOfProductLbl.text =  String(orderModel!.data![indexPath.row].data!.count)
        cell.checkoutPriceLbl.text  = orderModel?.data?[indexPath.row].orderPrice
        cell.orderDateLbl.text = orderModel?.data?[indexPath.row].datePurchased
     // cell.Configure(data: orderModel!.data![indexPath.section], orderData: orderModel!.data![indexPath.section].data![0])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OrderTableView.deselectRow(at: indexPath, animated: true)
        print("selected")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
