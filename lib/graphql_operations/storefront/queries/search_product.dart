/// Query search products
const String getSearchedProducts = r'''
query($country: CountryCode, $query: String!, $cursor : String, $limit : Int, $sortKey : SearchSortKeys, $reverse: Boolean, $filters: [ProductFilter!]) @inContext(country: $country) {
  search(query: $query, first: $limit, sortKey: $sortKey, after: $cursor, reverse: $reverse, productFilters: $filters, types: PRODUCT){
    pageInfo {
      hasNextPage
    }
    edges{
      cursor
      node{
        ... on Product {
          options(first: 50) {
            id
            name
            values
          } 
      id
      handle
      collections(first: 250) {
        edges {
          node {
            description
            descriptionHtml
            handle
            id
            updatedAt
            title
          }
        }
      }
      title
      availableForSale
      createdAt
      description
      descriptionHtml
      images(first: 250) {
          edges {
            node {
              altText
              id
              originalSrc
            }
          }
        }
      media(first: 250) {
          edges {
            node {
              alt
              id
              mediaContentType
              previewImage {
                altText
                id
                originalSrc
              }
            }
          }
        }
      variants(first: 250) {
        edges {
          node {
            priceV2 {
              amount
              currencyCode
            }
            title
            image {
              altText
              originalSrc
              id
            }
            compareAtPriceV2 {
              amount
              currencyCode
            }
            weightUnit
            weight
            availableForSale
            sku
            requiresShipping
             selectedOptions {
              name
              value
             }
            id
            quantityAvailable
          }
        }
      }
      onlineStoreUrl
      productType
      publishedAt
      tags
      updatedAt
      vendor
        }
      }
    }
  }
}
''';
