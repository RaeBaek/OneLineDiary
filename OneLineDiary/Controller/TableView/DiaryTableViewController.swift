//
//  DiaryTableViewController.swift
//  OneLineDiary
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

class DiaryTableViewController: UITableViewController {

    var list = ["테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1",
                "테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2테스트2",
                "테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3테스트3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
     
        // XIB로 테이블뷰 셀을 생성할 경우, 테이블뷰에 셀을 등록해주는 과정이 필요!
        let nib = UINib(nibName: DiaryTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DiaryTableViewCell.identifier)
        
//        tableView.backgroundColor = .clear
        
        //Dynamic Height: 1. automaticDimension, 2. label numberOfLines, 3. AutoLayout(여백)
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        // Search 아이콘 클릭 시 SearchCollectionViewController Push!
//        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SearchCollectionViewController") as? SearchCollectionViewController else {
            return
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addBarButtonItemClicked(_ sender: UIBarButtonItem) {
        
        // 1. 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 스토리보드 파일 내 뷰컨트롤러 찾기
        guard let vc = sb.instantiateViewController(withIdentifier: AddViewController.identifier) as? AddViewController else {
            return
        }
        
        vc.type = .add
        vc.contents = ""
        
        // 2-1(옵션). 네비게이션 컨트롤러가 있는 형태(제목바)로 Present 하고 싶은 경우
        //nav를 사용한다면, present와 화면 전환 방식도 nav로 수정 해주어야 한다.
        let nav = UINavigationController(rootViewController: vc)
        
        // 3. 화면 전환 방식 설정
//        nav.modalTransitionStyle = .crossDissolve // 모달 애니메이션
        nav.modalPresentationStyle = .fullScreen // 모달 방식
        
        // 4. 화면 띄우기
        present(nav, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier) as? DiaryTableViewCell else {
            return UITableViewCell()
        }
        
        cell.contentLabel.text = list[indexPath.row]
        cell.contentLabel.numberOfLines = 0
        cell.backgroundColor = .clear
        
        return cell
    }
    
    // 1. System Delete
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 2. System Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        list.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // DetailViewController(UIViewController) 생성해서 present 해보기!
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: AddViewController.identifier) as? AddViewController else {
            return
        }
        
        // Pass Data 2. vc가 가지고 있는 프로퍼티에 데이터 추가!
        vc.type = .edit
        vc.contents = list[indexPath.row]
        // 값 전달 시 Outlet을 활용할 수는 없음..
//        vc.contentsLabel.text = list[indexPath.row]
        
        // 인터페이스 빌더에 네비게이션 컨트롤러가 임베드 되어 있어야만 Push가 동작한다!
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    // Custom Swipe
//    // leading Swipe
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        UISwipeActionsConfiguration(actions: <#T##[UIContextualAction]#>)
//    }
//
//    // trailing Swipe
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }

}
