//
//  SearchCollectionViewController.swift
//  OneLineDiary
//
//  Created by 백래훈 on 2023/07/31.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController {

    let searchBar = UISearchBar()
    
    let list = ["iOS", "iPad", "Android", "Apple", "Watch", "사과", "사자", "호랑이"]
    var searchList: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요."
        searchBar.showsCancelButton = true
        
        navigationItem.titleView = searchBar
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        setCollectionViewLayout()
        
    }

    func setCollectionViewLayout() {
        
        // cell estimated size none으로 인터페이스 빌더에서 설정할 것!
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
        
    }
    
    // 1.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    // 2.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .brown
        cell.contentsLabel.text = searchList[indexPath.row]
        
        return cell
    }
}

extension SearchCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchList.removeAll()
        // 반복문 시작
        for item in list {
            // item이 서치바의 문자를 가지고 있다면?
            if item.contains(searchBar.text!) {
                // 서치 리스트에 추가
                searchList.append(item)
            }
        }
        
        // 추가 후 컬렉션 뷰 리로드!
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchList.removeAll()
        searchBar.text = ""
        collectionView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList.removeAll()
        // 반복문 시작
        for item in list {
            // item이 서치바의 문자를 가지고 있다면?
            if item.contains(searchBar.text!) {
                // 서치 리스트에 추가
                searchList.append(item)
            }
        }
        
        // 추가 후 컬렉션 뷰 리로드!
        collectionView.reloadData()
    }
    
}
